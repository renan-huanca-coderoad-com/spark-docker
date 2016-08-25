FROM anapsix/alpine-java
MAINTAINER ViZix "service@mojix.com"

RUN apk add --update unzip wget curl docker jq coreutils

ENV SPARK_VERSION="2.0.0" HADOOP_VERSION="2.7"

COPY download-spark.sh /tmp/download-spark.sh

RUN /tmp/download-spark.sh && tar xfz /tmp/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /opt && rm /tmp/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

# VOLUME ["/spark"]

ENV SPARK_HOME="/opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}"

COPY start-spark.sh /usr/bin/start-spark.sh

COPY spark-daemon.sh ${SPARK_HOME}/sbin/spark-daemon.sh
COPY start-master.sh ${SPARK_HOME}/sbin/start-master.sh

ENTRYPOINT ["start-spark.sh"]