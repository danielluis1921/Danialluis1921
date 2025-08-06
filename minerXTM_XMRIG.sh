#!/bin/sh
#read -p "What is Worker? (exp: vps01): " worker
#IP4=$(curl -4 -s icanhazip.com)
rm -fv danielchau.sh
sudo apt-get update -y
sudo apt-get install cpulimit -y
sudo apt-get install bc -y
wget --no-check-certificate -O xmrig.tar.gz https://github.com/xmrig/xmrig/releases/download/v6.24.0/xmrig-6.24.0-linux-static-x64.tar.gz
tar -xvf xmrig.tar.gz
chmod +x ./xmrig-6.24.0/* 
mv /root/xmrig-6.24.0/* /root/
cores=$(nproc --all)
country=$(curl -s ipinfo.io | jq -r '.country')
IP4=$(curl -4 -s icanhazip.com)
convert_dots_to_underscore() {
    echo "$1" | tr '.' '_'
}
IP4_UNDERSCORE=$(convert_dots_to_underscore "$IP4")

cat /dev/null > /root/config.json
cat >>/root/config.json <<EOF
{
    "pools": [
        {
            "algo": "rx/0",
            "coin": null,
            "url": "pool-global.tari.snipanet.com:3333",
            "user": "165DUuzQoKG9BaBqprN3ZmsMRfvGHMwNwCpehJUqGoGLsSDtB535XA3PPzfRZhu2uYM9xfT8JsKoXEquWMr6XVwKK4ek9swnax2avEDuGtGVpjfAuGdcQpFJjDqTg5T7YmJhTWE",
            "pass": "$country$cores-$IP4_UNDERSCORE",
            "rig-id": null,
            "nicehash": true,
            "keepalive": false,
            "enabled": true,
            "tls": false,
            "sni": false,
            "tls-fingerprint": null,
            "daemon": false,
            "socks5": null,
            "self-select": null,
            "submit-to-origin": false
        }  
    ]
}
EOF
cat /dev/null > /root/danielluis1921.sh
cat >>/root/danielluis1921.sh <<EOF
#!/bin/bash
./kill_miner.sh
screen -S XMR -X quit
sleep 3
screen -dmS XMR ./xmrig --donate-level 0 --threads=$cores --background -c config.json
sleep 3
EOF
chmod +x /root/danielluis1921.sh

wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod +x /root/kill_miner.sh
./kill_miner.sh
sleep 3
./danielluis1921.sh
sleep 20
