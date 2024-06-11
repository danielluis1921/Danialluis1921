#!/bin/sh
wget https://raw.githubusercontent.com/bicpter/temp-2/main/eth0-pre-install-uam.sh
sudo chmod 777 eth0-pre-install-uam.sh
./eth0-pre-install-uam.sh


wget https://raw.githubusercontent.com/bicpter/temp-2/main/generate-uam.sh
sudo chmod 777 generate-uam.sh
./generate-uam.sh 724EF397FB932375E2C4CD3F975AF445BD8B7D485FDD2907C08BAC41B7E06E2A 4

sudo apt-get install w3m w3m-img
#watch -n 1 "curl -s 127.0.0.1:17100 | w3m -T text/html"
