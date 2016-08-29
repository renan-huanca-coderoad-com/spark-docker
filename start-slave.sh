#!/usr/bin/env bash
# Starts a slave instance on each machine specified in the conf/slaves file.

CLASS="org.apache.spark.deploy.worker.Worker"

echo ">>> -1 SPARK_MASTER_PORT=$SPARK_MASTER_PORT"

SPARK_MASTER_PORT=${SPARK_MASTER_PORT:=7077}

echo ">>> -2 SPARK_MASTER_PORT=$SPARK_MASTER_PORT"

echo "SPARK_MASTER_HOST=$SPARK_MASTER_HOST"

if [ -z "$SPARK_MASTER_HOST" ]; then
  echo "SPARK_MASTER_HOST envvar is not defined."
  exit 1
fi

"${SPARK_HOME}"/bin/spark-class $CLASS spark://$SPARK_MASTER_HOST:$SPARK_MASTER_PORT
