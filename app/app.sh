#!/bin/bash
date
echo "Loading CSVs..."
python3 /tmp/app.py

echo "Converting CSVs to Parquet (few minutes...) and opening Spark SQL session..."
spark/bin/spark-sql --jars spark/jars/spark-csv_2.11-1.5.0.jar -S -f /tmp/converting_to_parquet.sql

echo "select
  distinct ISIN, Date, opening_price, closing_price,
  case when first_value(closing_price) over (partition by ISIN order by Date rows between 1 preceding and 1 preceding) is not null
  then round(((closing_price-first_value(closing_price) over (partition by ISIN order by Date rows between 1 preceding and 1 preceding))/
        first_value(closing_price) over (partition by ISIN order by Date rows between 1 preceding and 1 preceding))*100,2)
  else NULL
  end as percent_change_prev_closing
 from (
select distinct ISIN, Date,
first_value(StartPrice) over (partition by Date order by Time) as opening_price,
first_value(EndPrice) over (partition by Date order by Time desc) as closing_price,
sum(TradedVolume) over (partition by Date) as daily_traded_volume
from xetra_pds where ISIN = '$1');" > /tmp/app.sql

spark/bin/spark-sql --jars spark/jars/spark-csv_2.11-1.5.0.jar -S -i /tmp/app.sql