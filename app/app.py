from __future__ import print_function
import sys
import re

from pyspark.sql import SparkSession

if __name__ == "__main__":
    """
        Usage: pi [partitions]
    """
    spark = SparkSession \
        .builder \
        .appName("PythonPi") \
        .getOrCreate()

    sql_text = "create table photo (photo_id string, business_id string, caption string, label string) using org.apache.spark.sql.json options (path '/tmp/yelp/yelp_academic_dataset_photo.json')"
    spark.sql(sql_text)

    sql_text = "create table photo_3 using org.apache.spark.sql.json options (path '/tmp/yelp/yelp_academic_dataset_photo.json')"
    spark.sql(sql_text)


