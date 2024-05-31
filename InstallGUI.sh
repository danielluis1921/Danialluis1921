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

echo -e "123123\n123123\nn" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

vncserver :1 -geometry 1920x1080 -depth 24
sudo ufw allow 5901/tcp
sudo ufw reload

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install -f -y
