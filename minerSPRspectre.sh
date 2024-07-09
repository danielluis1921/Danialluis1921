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
mkdir spr
cd spr
wget https://github.com/spectre-project/spectre-miner/releases/download/v0.3.16/spectre-miner-v0.3.16-linux-gnu-amd64.zip
unzip spectre-miner-v0.3.16-linux-gnu-amd64.zip
cd bin
mv spectre-miner-v0.3.16-linux-gnu-amd64 spr
cd
screen -dmS spectre-pool spr/bin/spr -a spectre:qruhvld2xqd437vgwy6d8ajxnjmt92fcywgfy4pmmj0g5fzmlzcnwmdnlxgwt -s 172.105.239.139 -p 18110 -t 6
