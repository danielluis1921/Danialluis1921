#!/bin/sh
IP4=$(curl -4 -s icanhazip.com)
convert_dots_to_underscore() {
    echo "$1" | tr '.' '_'
}
IP4_UNDERSCORE=$(convert_dots_to_underscore "$IP4")
rm -fR /root/HAC
#read -p "What is Worker? (exp: vps01): " worker
sudo apt-get update -y
sudo apt-get install cpulimit
sudo apt install ocl-icd-opencl-dev -y
apt install unzip -y
wget --no-check-certificate -O HAC.zip https://github.com/hacash/miner/releases/download/v0.1.20/miner_pool_worker_ubuntu.zip
mkdir /root/HAC
unzip -o HAC.zip -d HAC
chmod +x ./HAC/* 
mv HAC/hacash_miner_pool_worker_2024_01_20_01_ubuntu16.04 HAC/HAC_ubuntu16.04
cores=$(nproc --all)
#rounded_cores=$((cores * 9 / 10))
#read -p "What is pool? (exp: fr-zephyr.miningocean.org): " pool
limitCPU=$((cores * 80))

cat /dev/null > /root/danielchau.sh
cat >>/root/danielchau.sh <<EOF
#!/bin/bash
sudo /root/HAC/HAC_ubuntu16.04 > /dev/null 2>&1 &
EOF
chmod +x /root/danielchau.sh

cat /dev/null > /root/HAC/poolworker.config.ini
cat >>/root/HAC/poolworker.config.ini <<EOF
pool = 108.181.156.247:3339
rewards = 13xymHri7PipAceBqBJ7N32XMvsqhN7DYx
supervene = $cores
EOF

wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod +x /root/kill_miner.sh
./kill_miner.sh
sleep 3
./danielchau.sh
sleep 10
