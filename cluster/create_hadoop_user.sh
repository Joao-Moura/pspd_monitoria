#!/bin/bash

USERNAME=$1
QUOTA_SIZE=${2:-1g}

user_path=/user/$USERNAME

hdfs dfs -mkdir -p $user_path
hdfs dfs -chown $USERNAME:$USERNAME $user_path
hdfs dfs -chmod 700 $user_path

if [[ $QUOTA_SIZE -gt 0 ]]; then
	hdfs dfsadmin -setSpaceQuota $QUOTA_SIZE $user_path
fi
