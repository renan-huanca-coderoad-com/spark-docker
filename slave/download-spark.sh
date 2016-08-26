#!/bin/sh
url="http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"
wget -q "${url}" -O "/tmp/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"