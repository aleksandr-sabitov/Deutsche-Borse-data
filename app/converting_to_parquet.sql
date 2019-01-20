create table if not exists xetra_pds_csv  using  com.databricks.spark.csv
OPTIONS (path "/tmp/deutsche-boerse-xetra-pds/", header "true", inferSchema "true");

create table if not exists xetra_pds
using parquet options (compression = 'uncompressed',path '/tmp/deutsche-boerse-xetra-pds-parquet/xetra_pds')
 as select * from xetra_pds_csv;


