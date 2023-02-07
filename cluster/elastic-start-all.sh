#!/bin/bash

SOURCE_ENV="source bin/chococino_env;";

ssh cm1 "$SOURCE_ENV $ELASTIC_BIN_HOME/bin/elasticsearch -d"
ssh cm4 "$SOURCE_ENV screen -dmS kibana $KIBANA_BIN_HOME/bin/kibana"
