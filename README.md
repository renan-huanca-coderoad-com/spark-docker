
Using docker composer
---------------------

> docker-compose up -d

> docker-compose scale spark-slave=5


Using docker command
--------------------

Start spark server:
docker run -d -h spark-master --name spark-master -p 2222:22 -p 8081:8080 -p 7077:7077 -p 6066:6066 -e SPARK_MASTER_HOST=spark-master -e SPARK_INSTANCE_TYPE=master myspark

Start spark worker:
docker run -d -h spark-slave --name spark-slave -p 8082:8081 -e SPARK_MASTER_HOST=spark-master -e SPARK_INSTANCE_TYPE=slave --link spark-master myspark


