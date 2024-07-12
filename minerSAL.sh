#!/bin/sh
sudo apt-get update -y
sudo apt install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y
git clone https://github.com/salvium/xmrig.git
mkdir xmrig/build && cd xmrig/build
cmake ..
make -j$(nproc)
screen -dmS sal ./xmrig -o 172.104.102.78:19081 -u SaLvdWJH7A2CncTWamHp19ZTAJwQzzUzgMhNvyBaQ4VCW9zHauUNVcLdF1FiUunwUZ6GL6C36227BNZjSpFi3pZtSWGENhZJhdV --coin=SAL --daemon -t 6
