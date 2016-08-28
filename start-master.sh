#!/usr/bin/env bash

# NOTE: This exact class name is matched downstream by SparkSubmit.
# Any changes need to be reflected there.
CLASS="org.apache.spark.deploy.master.Master"
SPARK_MASTER_HOST=${SPARK_MASTER_HOST:='localhost'}
SPARK_MASTER_PORT=${SPARK_MASTER_PORT:=7077}
SPARK_MASTER_WEBUI_PORT=${SPARK_MASTER_WEBUI_PORT:=8080}

echo
echo "SPARK_MASTER_HOST: $SPARK_MASTER_HOST"
echo "SPARK_MASTER_PORT: $SPARK_MASTER_PORT"
echo "SPARK_MASTER_WEBUI_PORT: $SPARK_MASTER_WEBUI_PORT"

# . "${SPARK_HOME}/sbin/spark-config.sh"
# . "${SPARK_HOME}/bin/load-spark-env.sh"

echo
"${SPARK_HOME}"/bin/spark-class $CLASS \
  --host $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT