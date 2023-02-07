#!/bin/bash

# Usage: bash create_elastic_student.sh <USERNAME> <PASSWORD>

USERNAME=$1
PASSWORD=$2

if [[ -z $USERNAME ]]; then
	echo "Usage: $0 <USERNAME> <PASSWORD>"
	exit 1
fi

function kibana_api_send {
	METHOD=$1
	RESOURCE=$2
	DATA=$3

	curl -X $METHOD $KIBANA_HOST/$RESOURCE -H 'kbn-xsrf: true' -H "Authorization: ApiKey $ELASTIC_APIKEY" -d "$DATA" -H 'Content-Type: application/json' --compressed
}


echo -e "\nCriando space $USERNAME ..."
kibana_api_send POST api/spaces/space "$(cat <<-EOF
	{"id": "$USERNAME", "name": "$USERNAME"}
	EOF
	)"

echo -e "\nCriando role $USERNAME ..."
kibana_api_send PUT "api/security/role/$USERNAME" "$(cat <<-EOF
	{
	  "elasticsearch": {
	    "cluster" : [ "monitor" ],
	    "indices" : [ {
	    		"names": ["student-$USERNAME-*"],
	    		"privileges": [ "monitor", "read", "write", "create_index", "view_index_metadata"]
	    	} ]
	  },
	  "kibana": [
	    {
	      "base": [ "all" ],
	      "spaces": [
	        "$USERNAME"
	      ]
	    }
	  ]
	}

	EOF
	)"


echo -e "\nCriando usuario $USERNAME ..."
kibana_api_send POST internal/security/users/$USERNAME "$(cat <<-EOF
	{
		"password":"$PASSWORD",
		"username":"$USERNAME",
		"full_name":"",
		"email":"",
		"roles":["$USERNAME"]
	}
	EOF
	)"


echo
