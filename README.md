# Deutsche Börse dataset - Spark SQL case (Linux/Mac/Win with some caveats)
This repository is used to demo Spark SQL case for Deutsche Börse dataset - https://github.com/Deutsche-Boerse/dbg-pds

#### One time activies - in order to be able to run things

- [Install Docker](https://www.docker.com/community-edition#/download) on your machine
- [Install Docker Compose](https://docs.docker.com/compose/install/) on your machine

#### How it works
0) ...based on boto3 Python lib and Spark docker provided by https://github.com/big-data-europe/docker-spark
1) Startup Spark master + one Spark worker in standalone mode (pretening to be Spark cluster)
2) Startup (customized ) Spark client container ("application")
3) Loading (incremental) data by boto3 from S3 (using anonymized connection)
4) Converting CSV formats into Parquet formats using Spark SQL
5) Running Spark SQL query that generate needed result
6) Exposing spark-sql console 

#### TODO
0) get rid of hardcoded values
1) implement incremental load with support from Airflow or implementing some custom increment control
2) add support for date formats
3) introduce table partitions 
4) introduce unit-tests on data checks ()

#### How to use
Firstly clone this repo to local machine.
Then you can use it against S3 data with needed ISIN-code:

```bash
 ./start.sh DE0007037145
```

It will take 3-5 minutes (depending on your hardware) until preparations (converting toi Parquet format) done, then you can try to play with data by using provided *spark-sql* console.
```sql
spark-sql> show tables;

```

With `quit; `command inide spark-sql console docker-compose will shutdown everything:
```bash
spark-sql> quit;
Stopping spark-client   ... done
Stopping spark-worker-1 ... done
Stopping spark-master   ... done
Removing spark-client   ... done
Removing spark-worker-1 ... done
Removing spark-master   ... done

```

#### In case of faulires during start or usage 
You can also double check that docker containers are down by command:
`docker-compose down` 

