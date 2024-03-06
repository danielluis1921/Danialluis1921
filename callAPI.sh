#!/bin/sh

IP4=$(curl -4 -s icanhazip.com)
pid=$(pgrep SRBMiner-MULTI)
if [ -z "$pid" ]; then
  curl -X GET "http://162.55.58.220:5001/api/myipv4/$IP4"
else
  echo "SRBMiner-MULTI is running"
fi
