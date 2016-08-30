
Using docker composer
---------------------

> docker-compose up -d
> docker-compose scale spark-slave=5


Using docker command
--------------------

Start spark server:
> docker run -d -h spark-master --name spark-master -p 8080:8080 -e SPARK_MASTER_HOST=spark-master -e SPARK_INSTANCE_TYPE=master myspark

Start spark worker:
> docker run -d -h spark-slave --name spark-slave -p 8081:8081 -e SPARK_MASTER_HOST=spark-master -e SPARK_INSTANCE_TYPE=slave --link spark-master myspark



