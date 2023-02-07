#!/bin/bash

SOURCE_ENV="source bin/chococino_env;";

ssh cm1 "kill -15 $(jps | grep Elasticsearch | cut -d' ' -f1)"
ssh cm4 "screen -XS kibana quit; screen -wipe"
