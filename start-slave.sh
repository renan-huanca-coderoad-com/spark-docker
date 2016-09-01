#!/usr/bin/env bash
# Starts a slave instance on each machine specified in the conf/slaves file.

CLASS="org.apache.spark.deploy.worker.Worker"

# fixing SPARK_MASTER_PORT
# for some reason in docker and when using --link argument
# this var starts with value: tcp://172.17.0.2:8080
if [[ ${SPARK_MASTER_PORT:0:3} == 'tcp' ]]
then
    unset SPARK_MASTER_PORT
fi

SPARK_MASTER_PORT=${SPARK_MASTER_PORT:=7077}

if [ -z "$SPARK_MASTER_HOST" ]; then
  echo "SPARK_MASTER_HOST envvar is not defined."
  exit 1
fi

echo
echo "SPARK_MASTER_HOST: $SPARK_MASTER_HOST"
echo "SPARK_MASTER_PORT: $SPARK_MASTER_PORT"

echo
"${SPARK_HOME}"/bin/spark-class $CLASS spark://$SPARK_MASTER_HOST:$SPARK_MASTER_PORT
