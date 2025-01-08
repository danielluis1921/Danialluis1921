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

echo -e "Lana5262!\Lana5262!\nn" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

vncserver :2 -geometry 1920x1080 -depth 24
sudo ufw allow 5902/tcp
sudo ufw reload

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install -f -y
#rm -fR /root/.config/google-chrome
#wget https://github.com/danielluis1921/Danialluis1921/raw/main/Default.zip
#mkdir .config/google-chrome
#unzip Default.zip -d /root/.config/google-chrome/
