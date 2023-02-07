#!/bin/bash

SOURCE_ENV="source bin/chococino_env;";

ssh cm1 "$SOURCE_ENV $SPARK_BIN_HOME/sbin/start-all.sh"
