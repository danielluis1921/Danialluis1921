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
screen -dmS salvium ./xmrig -a rx/0 --url 116.203.206.166:3321
