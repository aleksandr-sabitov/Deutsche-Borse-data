FROM bde2020/spark-submit:2.4.0-hadoop2.7
MAINTAINER alksndr.sbtv@gmail.com

RUN wget http://central.maven.org/maven2/com/databricks/spark-csv_2.11/1.5.0/spark-csv_2.11-1.5.0.jar -P /tmp \
 && cp /tmp/spark-csv_2.11-1.5.0.jar /spark/jars

RUN pip3 install boto3

COPY app/* /tmp/
COPY scripts/entrypoint.sh /

CMD ["/bin/bash", "/entrypoint.sh"]