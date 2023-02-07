#!/bin/bash

# USAGE: bash create_hadoop_user.sh <USERNAME> <QUOTA_SIZE>

USERNAME=$1
QUOTA_SIZE=${2:-1g}


if [[ -z "$USERNAME" ]]; then
	exit 1;
fi


user_path=/user/$USERNAME


hdfs dfs -mkdir -p $user_path
hdfs dfs -chown $USERNAME:$USERNAME $user_path
hdfs dfs -chmod 775 $user_path
hdfs dfsadmin -setSpaceQuota $QUOTA_SIZE $user_path
