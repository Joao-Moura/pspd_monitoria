#!/bin/bash

SOURCE_ENV="source bin/chococino_env;"

for hostname in cm{1,2,3,4} gpu{1,2,3}; do
	ssh $hostname "$SOURCE_ENV kafka-server-stop.sh"
done

ssh cm2 "$SOURCE_ENV zookeeper-server-stop.sh"
