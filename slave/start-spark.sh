#!/bin/bash

SPARK_PID=0

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

# Capture kill requests to stop properly
trap "term_handler" SIGHUP SIGINT SIGTERM

"${SPARK_HOME}"/sbin/start-slave.sh 

SPARK_PID=$!

wait