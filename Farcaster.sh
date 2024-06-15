#!/bin/bash
sudo apt-get install expect -y
apt install tmux -y
sudo apt update -y
apt-get install ufw
yes | ufw enable
ufw status
ufw allow 22/tcp
ufw allow 2281/tcp
ufw allow 2282/tcp
ufw allow 2283/tcp
ufw allow ssh

wget https://download.thehubble.xyz/bootstrap.sh

cat >>/root/Farcaster.exp <<EOF
#!/usr/bin/expect -f
set timeout -1
spawn bash bootstrap.sh

expect "> Enter your Ethereum Mainnet RPC URL: "
send "https://eth-mainnet.g.alchemy.com/v2/1_akFV_Gp-07bzDHweQvB9zRouDRX4jK\r"

expect "> Enter your Optimism L2 Mainnet RPC URL: "
send "https://opt-mainnet.g.alchemy.com/v2/NAnXFMTXQ3PlIziXdW1fs2hMD-N8c6Yx\r"

expect "> Your FID or farcaster username: "
send "674637\r"


# Wait for the script to complete
expect eof
EOF


# Name of the screen session
SCREEN_NAME="Hubble"

# Path to the expect script
EXPECT_SCRIPT="Farcaster.exp"

# Start a new screen session and run the expect script
screen -dmS $SCREEN_NAME expect $EXPECT_SCRIPT

# Detach from the screen session (this is done automatically with -dmS option)
#screen -S $SCREEN_NAME -X detach

echo "Script is running in screen session: $SCREEN_NAME"
