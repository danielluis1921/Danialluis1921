#!/bin/sh
wget https://raw.githubusercontent.com/bicpter/temp-2/main/eth0-pre-install-uam.sh
sudo chmod 777 eth0-pre-install-uam.sh
./eth0-pre-install-uam.sh


wget https://raw.githubusercontent.com/bicpter/temp-2/main/generate-uam.sh
sudo chmod 777 generate-uam.sh
./generate-uam.sh 05D67162AC6E3701AC183D614F53C6A2D58D0BC063B1F16217969DD4C6263609 4

sudo apt-get install w3m w3m-img
#watch -n 1 "curl -s 127.0.0.1:17100 | w3m -T text/html"
