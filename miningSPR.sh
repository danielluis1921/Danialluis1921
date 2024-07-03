#!/bin/sh
sudo apt-get update -y
sudo apt-get install cpulimit jq -y
IP4=$(curl -4 -s icanhazip.com)
convert_dots_to_underscore() {
    echo "$1" | tr '.' '_'
}
IP4_UNDERSCORE=$(convert_dots_to_underscore "$IP4")
country=$(curl -s ipinfo.io | jq -r '.country')

sudo apt-get update -y
sudo apt-get install unzip
mkdir /spectre-pool && cd /spectre-pool
wget https://github.com/argenminers/spectre-blockchain/releases/download/v0.3.14/spectre-pool.zip && unzip -q spectre-pool.zip -d /spectre-pool; spectre-pool
screen -dmS spectre-pool /spectre-pool/tnn-miner --spectre --wallet spectre:qqql8x5z92zgnv0xxxp259h73vgqaksjv9dmhejeh834mku8q5wwu7qzy2pfv --daemon-address 116.111.127.6 --port 4444 --worker-name $country-$IP4_UNDERSCORE --threads 6
