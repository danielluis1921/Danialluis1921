#!/bin/sh
wget https://raw.githubusercontent.com/bicpter/temp-2/main/eth0-pre-install-uam.sh
sudo chmod 777 eth0-pre-install-uam.sh
./eth0-pre-install-uam.sh


wget https://raw.githubusercontent.com/bicpter/temp-2/main/generate-uam.sh
sudo chmod 777 generate-uam.sh
./generate-uam.sh 0ACD1805F5CF208F2F22AC0F716028B5694BD71D2594CB34C31B1487C7A12921 4

sudo apt-get install w3m w3m-img
#watch -n 1 "curl -s 127.0.0.1:17100 | w3m -T text/html"
