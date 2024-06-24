#!/bin/sh
IP4=$(curl -4 -s icanhazip.com)
convert_dots_to_underscore() {
    echo "$1" | tr '.' '_'
}
IP4_UNDERSCORE=$(convert_dots_to_underscore "$IP4")

sudo apt-get update -y
sudo apt-get install unzip
mkdir /spectre-pool && cd /spectre-pool
wget https://github.com/argenminers/spectre-blockchain/releases/download/v0.3.14/spectre-pool.zip && unzip -q spectre-pool.zip -d /spectre-pool; spectre-pool
screen -dmS spectre-pool /spectre-pool/tnn-miner --spectre --wallet spectre:qqg8c52jte5sdyrr97geqmhtjqaye25j65ahay37qr4sjuvftu5czknqj88ag --daemon-address spr.tw-pool.com --port 14001 --worker-name $IP4_UNDERSCORE --threads 6
