#!/bin/sh
vncserver -kill :1
sudo DEBIAN_FRONTEND=noninteractive apt remove tigervnc-standalone-server tigervnc-common -y
sudo DEBIAN_FRONTEND=noninteractive apt remove ubuntu-desktop -y
rm -fR ~/.vnc
