FROM bde2020/spark-submit:2.4.0-hadoop2.7
MAINTAINER alksndr.sbtv@gmail.com

COPY app/app.sh /tmp/app.sh
COPY app/convert_to_parquet.sql /tmp/convert_to_parquet.sql
COPY app/sql_examples.sql /tmp/sql_examples.sql
COPY scripts/entrypoint.sh /

CMD ["/bin/bash", "/entrypoint.sh"]