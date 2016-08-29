#!/bin/bash

set -e

SPARK_INSTANCE_TYPE=${SPARK_INSTANCE_TYPE:='master'}

# Echoing settings for debug purposes

echo
echo "SPARK_INSTANCE_TYPE: $SPARK_INSTANCE_TYPE"
echo "SPARK_HOME: $SPARK_HOME"

## UTILITY FUNCTION(S)
## -------------------
# see https://medium.com/@gchudnov/trapping-signals-in-docker-containers-7a57fdda7d86#.bh35ir4u5
term_handler() {
  echo 'Stopping Spark....'
  if [ $SPARK_PID -ne 0 ]; then
    kill -s TERM "$SPARK_PID"
    wait "$SPARK_PID"
  fi
  echo 'Spark stopped.'
  exit
}

## MAIN
## ----

# Capture kill requests to stop properly
trap "term_handler" SIGHUP SIGINT SIGTERM

SPARK_PID=0
case $SPARK_INSTANCE_TYPE in

	'master')
	echo
	echo "Starting master..."
	start-master.sh &
	;;

	'slave')
	echo
	echo "Starting slave..."
	start-slave.sh &
	;;

	*)
	echo "ERROR: SPARK_INSTANCE_TYPE is empty or invalid. Exiting...";
	exit 1
	;;
esac

SPARK_PID=$!
wait
