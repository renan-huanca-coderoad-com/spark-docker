spark master and slave configuration

Start spark server:
docker run -d --name spark-master -h spark-master -p 8080:8080 myspark

Start spark worker:
docker run -d --name spark-slave -h spark-slave -p 8081:8081 -e SPARK_MASTER_HOST=spark-master  --link spark-master spark-slave
