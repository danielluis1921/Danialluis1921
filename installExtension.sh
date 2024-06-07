#!/bin/sh
rm -fR /root/.config/google-chrome
wget https://github.com/danielluis1921/Danialluis1921/raw/main/Default.zip
mkdir .config/google-chrome
unzip Default.zip -d /root/.config/google-chrome/
