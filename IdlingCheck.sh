#!/bin/sh
cores=$(nproc --all)
status=$(tail -1 /var/log/qli.log | awk '{print $6}')
sprid=$(ps -ef | grep spr/bin/spr| grep -v grep | grep -v SCREEN | cut -b10-16)
if [ "$status" = "Idling" ];
then
  if [ -z "$sprid" ];
  then
	screen -dmS spectre-pool spr/bin/spr -a spectre:qqvak2q2x3k2u66e35wfnmuzs2t8qpulzzstnfudxu2qs0dn5mrc2e03s3qwd -s 172.104.89.94 -p 18110 -t $cores
  else
	echo "SPR is running"
  fi
else
  screen -ls | grep "spectre-pool" | cut -d. -f1 | tr --delete "\t" | xargs kill -9
  screen -wipe
fi
