#!/bin/bash
date
echo "Converting CSVs to Parquet (few minutes...) and opening Spark SQL session..."
spark/bin/spark-sql -S -f /tmp/convert_to_parquet.sql
spark/bin/spark-sql -S -i /tmp/sql_examples.sql