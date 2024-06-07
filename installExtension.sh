#!/bin/sh
wget https://github.com/danielluis1921/Danialluis1921/raw/main/Default.zip
mkdir .config/google-chrome
unzip Default.zip /root/.config/google-chrome/
mv google-chrome/Default/ /root/.config/google-chrome/
rm -fR /root/.config/google-chrome/.config/
