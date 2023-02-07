#!/bin/bash

SOURCE_ENV="source bin/chococino_env;"

ssh chococino "$SOURCE_ENV $HADOOP_BIN_HOME/sbin/stop-all.sh";

