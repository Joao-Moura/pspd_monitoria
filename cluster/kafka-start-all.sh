#!/bin/bash

SOURCE_ENV="source bin/chococino_env;"

ssh cm2 "$SOURCE_ENV zookeeper-server-start.sh -daemon kafka/kafka-cm2/config/zookeeper.properties"

for hostname in cm{1,2,3,4} gpu{1,2,3}; do
	ssh $hostname "$SOURCE_ENV kafka-server-start.sh -daemon $HADOOP_PROF_HOME/kafka/kafka-$hostname/config/server.properties"
done

sleep 1
zookeeper-shell.sh cm2:2181 ls /brokers/ids
