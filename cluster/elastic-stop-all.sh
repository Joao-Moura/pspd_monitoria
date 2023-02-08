#!/bin/bash

ssh cm1 << EOF
	kill -15 \$(jps | grep Elasticsearch | cut -d' ' -f1)
EOF

ssh cm4 "screen -XS kibana quit; screen -wipe"
