# Deutsche Börse dataset - Spark SQL case (Linux/Mac)
This repository is used to demo Spark SQL case for Deutsche Börse dataset - https://github.com/Deutsche-Boerse/dbg-pds

#### One time activies - in order to be able to run things

- [Install Docker](https://www.docker.com/community-edition#/download) on your machine
- [Install Docker Compose](https://docs.docker.com/compose/install/) on your machine

#### How it works
0) ...based on boto3 and Spark docker provided by https://github.com/big-data-europe/docker-spark
1) Startup Spark master + one Spark worker in standalone mode (pretening to be Spark cluster)
2) Startup (customised ) Spark client container ("application") + attach tar-file as docker volume
3) Loading (incremental) data by boto3 from S3
4) Converting CSV formats into Parquet formats using Spark SQL
5) SQL query that needed result

#### TODO
1) add support for date formats
2) introduce table partitions 
3) introduce unit-tests on data checks

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

