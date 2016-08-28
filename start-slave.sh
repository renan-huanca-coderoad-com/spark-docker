#!/usr/bin/env bash
echo "=====>>>><<<<<----1 $SPARK_MASTER_PORT"
# Starts a slave instance on each machine specified in the conf/slaves file.

echo "=====>>>><<<<<----2 $SPARK_MASTER_PORT"
CLASS="org.apache.spark.deploy.worker.Worker"

echo "=====>>>><<<<<----3 $SPARK_MASTER_PORT"
if [ -z "${SPARK_HOME}" ]; then
  export SPARK_HOME="$(cd "`dirname "$0"`"/..; pwd)"
fi

echo "=====>>>><<<<<----4 $SPARK_MASTER_PORT"

. "${SPARK_HOME}/sbin/spark-config.sh"

echo "=====>>>><<<<<----5 $SPARK_MASTER_PORT"

. "${SPARK_HOME}/bin/load-spark-env.sh"

echo "=====>>>><<<<<----6 $SPARK_MASTER_PORT"

# Find the port number for the master
if [ "$SPARK_MASTER_PORT" = "" ]; then
  SPARK_MASTER_PORT=7077
fi

echo "=====>>>><<<<<----6 $SPARK_MASTER_PORT"

if [ "$SPARK_MASTER_HOST" = "" ]; then
  SPARK_MASTER_HOST="`hostname`"
fi

echo "=====>>>><<<<<----7 $SPARK_MASTER_PORT"

"${SPARK_HOME}"/bin/spark-class $CLASS spark://$SPARK_MASTER_HOST:7077
