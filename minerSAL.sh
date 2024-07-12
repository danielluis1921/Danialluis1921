#!/bin/sh
sudo apt-get update -y
sudo apt install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y
git clone https://github.com/salvium/xmrig.git
mkdir xmrig/build && cd xmrig/build
cmake ..
make -j$(nproc)
screen -dmS sal ./xmrig -o 172.104.102.78:19081 -u SaLvdVBC5dQbKEFW1fuoszMR3tLEfekAd6bJbir9n47aamVZQN96KjqeanYCq6WM6HTUDKnfy6GnZ6y7EsRg5j8CUKbvi5cq8vP --coin=SAL --daemon -t 6
