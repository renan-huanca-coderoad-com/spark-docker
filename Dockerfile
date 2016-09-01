FROM anapsix/alpine-java
MAINTAINER ViZix "service@mojix.com"

RUN apk add --update unzip wget curl docker jq coreutils

ENV SPARK_VERSION="2.0.0" HADOOP_VERSION="2.7"

COPY download-spark.sh /tmp/download-spark.sh

RUN /tmp/download-spark.sh && tar xfz /tmp/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /opt && rm /tmp/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

USER root

RUN apk add --update openssh rsync

# passwordless ssh
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ed25519_key
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

ADD ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

ENV SPARK_HOME="/opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}"
ENV SPARK_WORKER_OPTS="-Dlog4j.configuration=${SPARK_HOME}/conf/log4j.properties"

COPY start-master.sh /usr/bin/start-master.sh
COPY start-slave.sh /usr/bin/start-slave.sh
COPY log4j.properties ${SPARK_HOME}/conf/log4j.properties
COPY run.sh /run.sh

EXPOSE 22 8080 8081 7077 6066
ENTRYPOINT ["/run.sh"]
