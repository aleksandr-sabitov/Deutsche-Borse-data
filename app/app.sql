create table xetra_pds_csv using  com.databricks.spark.csv
OPTIONS (path "/tmp/deutsche-boerse-xetra-pds/", header "true", inferSchema "true");

create table xetra_pds
using parquet options (compression = 'uncompressed',path '/tmp/deutsche-boerse-xetra-pds-parquet/test1')
 as select * from xetra_pds_csv;

 select distinct ISIN, Date,
 first_value(StartPrice) over (partition by Date order by Time) as opening_price,
 first_value(EndPrice) over (partition by Date order by Time desc) as closing_price,
 sum(TradedVolume) over (partition by Date) as daily_traded_volume
 from test1_parquet where ISIN = 'DE0007037145';
