#!/usr/bin/env bash
set -euo pipefail

ACCESS_TOKEN="eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjM0NjZmNGFiLTAxZTItNDgxNS1iNTRhLTczNTA4YjA4ZDdhMCIsIk1pbmluZyI6IiIsIm5iZiI6MTc4MjExMTE0NCwiZXhwIjoxODEzNjQ3MTQ0LCJpYXQiOjE3ODIxMTExNDQsImlzcyI6Imh0dHBzOi8vcXViaWMubGkvIiwiYXVkIjoiaHR0cHM6Ly9xdWJpYy5saS8ifQ.VMgY8jJXLzGe1PCW4a7py31R7bSJpqvlC_bI6p7ULsgjEgx0wPyiiphoH3AIhST3ZomkHvji2OYqxNQjncI4kRxvERqAOlBsSwtDxedSu7UDPYBoN83xbbnGKAG5_ZQI5BtcC01x0_-ElvuxYFRq2mmlUOO6n-MH4Wz-iV2bc7s-3d-JQrIavTSRExF4H8cQDt8wX_RFMU_-puyC2cYY8HuNCFCTTkr_yNPgZEai9nloqSHRSHN8S6Hd5pDL6XoEYMCZLIEE4g2ccie3SfCs6lAkgNgJaEXTg6Q5IbyfP5cjKX4FGAFuBq7pCedbYsDF6rLHX8lNbaU-jlBCiqiCog"
POOL_ADDRESS="wss://wps.qubic.li/ws"
INSTALL_URL="https://dl.qubic.li/cloud-init/qli-Service-install-auto.sh"

# ===== Basic info =====
CORES="$(nproc --all)"
IP4="$(curl -4 -s https://icanhazip.com || hostname -I | awk '{print $1}')"
IP4_SAFE="$(echo "$IP4" | tr '.' '_')"
COUNTRY="$(curl -s https://ipinfo.io/country || echo XX)"
ALIAS="${COUNTRY}${CORES}-${IP4_SAFE}"

echo "[INFO] Cores: $CORES"
echo "[INFO] IP: $IP4"
echo "[INFO] Alias: $ALIAS"

# ===== Packages =====
apt-get update -y
apt-get install -y curl wget jq unzip

# ===== HugePages =====
# Epoch 218 recommendation:
# AVX2/GENERIC: 90 hugepages per thread
HUGEPAGES=$((CORES * 90))

echo "[INFO] Setting HugePages: $HUGEPAGES"
sysctl -w vm.nr_hugepages="$HUGEPAGES"

cat >/etc/sysctl.d/99-qubic-hugepages.conf <<EOF
vm.nr_hugepages=$HUGEPAGES
EOF

# ===== Prepare directory =====
mkdir -p /q
cd /q

# ===== Stop old service if exists =====
if systemctl list-unit-files | grep -q '^qli.service'; then
    systemctl stop qli || true
fi

# ===== Download official installer =====
wget -O /q/qli-Service-install.sh "$INSTALL_URL"
chmod +x /q/qli-Service-install.sh

# ===== Install QLI service =====
# Format: installer <threads> <token> <alias>
/q/qli-Service-install.sh "$CORES" "$ACCESS_TOKEN" "$ALIAS"

# ===== Write appsettings.json =====
cat >/q/appsettings.json <<EOF
{
  "ClientSettings": {
    "poolAddress": "$POOL_ADDRESS",
    "trainer": {
      "cpu": true,
      "gpu": false,
      "cpuThreads": $CORES,
      "cpuVersion": "AVX2"
    },
    "alias": "$ALIAS",
    "pps": true,
    "accessToken": "$ACCESS_TOKEN",
    "autoUpdate": true,
    "displayDetailedHashrates": true,
    "displayUptime": true
  }
}
EOF

# ===== Restart service =====
systemctl daemon-reload
systemctl enable qli
systemctl restart qli

sleep 5

echo "[INFO] QLI service status:"
systemctl --no-pager status qli || true

echo "[INFO] Latest log:"
tail -n 30 /var/log/qli.log || true
