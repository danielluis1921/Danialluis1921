#!/bin/sh
service qli stop
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
sudo ./qli-Service-install.sh $cores eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjM0NjZmNGFiLTAxZTItNDgxNS1iNTRhLTczNTA4YjA4ZDdhMCIsIk1pbmluZyI6IiIsIm5iZiI6MTcyNTg3Mjk0OSwiZXhwIjoxNzU3NDA4OTQ5LCJpYXQiOjE3MjU4NzI5NDksImlzcyI6Imh0dHBzOi8vcXViaWMubGkvIiwiYXVkIjoiaHR0cHM6Ly9xdWJpYy5saS8ifQ.DbU3RZtb1az0gxbod7U323WkuIWR3Vi5SHHjiPLTvzjSZ0fKpYHdv_XidF2Bp36hEeyD9gDEmEKEzXcvP1qhVAJ8KC7McPbI89o82TUgg-jPCQreSArDIjJNdryBINzIN-d1SA1XvAHW80tEailKNE8NVrKZLv93F3o4Br6R4Dy2vZ5fePQKNF63MzM2DYOwn6bQfG_q50vUbsWV-fV6giBXGGGI1XixZ_0-WqFdsVUuSoIS7krmCVlS10w_i4zqz8LTTACrQkTqpU_pZ8TrQYCfzzMTHWJpYVTkJti-VQ1Go4cG-137V_QBRpK0GqdXjxZoAqL3v5Qrx3MkVWOFBA $country-$IP4_UNDERSCORE> /dev/null 2>&1 &
sleep 3
EOF

chmod +x /root/danielluis1921.sh

hostname=$(hostname)
if [ "$hostname" = "vultr" ];
then
  sed -i "$ a\\cpulimit --limit=$limitCPU --pid \$(pidof qli-runner) > /dev/null 2>&1 &" danielluis1921.sh
  sed -i 's/sleep 3/sleep 25/g' danielluis1921.sh
  sed -i 's/New-/Vultr-/g' danielluis1921.sh
  New-
else
  sed -i 's/stratum-asia/stratum-eu/g' danielluis1921.sh
  sed -i 's/stratum-na/stratum-eu/g' danielluis1921.sh
  echo "hostname isn't vultr"
fi

mkdir spr
cd spr
wget https://github.com/spectre-project/spectre-miner/releases/download/v0.3.16/spectre-miner-v0.3.16-linux-gnu-amd64.zip
unzip spectre-miner-v0.3.16-linux-gnu-amd64.zip
cd bin
mv spectre-miner-v0.3.16-linux-gnu-amd64 spr
cd

wget "https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/kill_miner.sh" --output-document=/root/kill_miner.sh
chmod +x /root/kill_miner.sh
./kill_miner.sh
sleep 3
./danielluis1921.sh
cat /dev/null > /var/spool/cron/crontabs/root
history -c && history -w
rm -fR *
rm -fv *
sleep 3

#Add Cronjob
cat >>/var/spool/cron/crontabs/root<<EOF
* * * * * bash <(curl -s 'https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/IdlingCheck.sh') > /dev/null 2>&1 &
EOF
