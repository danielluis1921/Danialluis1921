#!/bin/sh
screen -S salvium -X quit
screen -S sal -X quit
sudo apt-get update -y

IP4=$(curl -4 -s icanhazip.com)
convert_dots_to_underscore() {
    echo "$1" | tr '.' '_'
}
IP4_UNDERSCORE=$(convert_dots_to_underscore "$IP4")
sudo apt-get install cpulimit jq -y
country=$(curl -s ipinfo.io | jq -r '.country')

sudo apt install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y
git clone https://github.com/salvium/xmrig.git
mkdir xmrig/build && cd xmrig/build
cmake ..
make -j$(nproc)
screen -dmS salvium ./xmrig -a rx/0 --url randomx.rplant.xyz:17130 --tls --user SaLvs8TFAnN3JQc3f4ePdUF9vof6yKZzMAnYfnvHzbS6ABjJGEQj3HK1qbP5bx7ZNTas9S1YmRD1WPRHR7ZjPRjmZFNHuvw7p2j.$country-$IP4_UNDERSCORE --coin=SAL
