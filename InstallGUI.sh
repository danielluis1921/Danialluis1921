#!/bin/sh
sudo DEBIAN_FRONTEND=noninteractive apt update && sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
sudo DEBIAN_FRONTEND=noninteractive apt install ubuntu-desktop -y
sudo DEBIAN_FRONTEND=noninteractive apt install tigervnc-standalone-server tigervnc-common -y
mkdir -p ~/.vnc
cat >>~/.vnc/xstartup <<EOF
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec gnome-session &
EOF

chmod +x ~/.vnc/xstartup
vncserver :1 -geometry 1920x1080 -depth 24
sudo ufw allow 5901/tcp
sudo ufw reload
