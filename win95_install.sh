#/!bin/bash


echo "INSTALLATION DE WINDOW 95 /!\ DEPENDANCES"
cd ~/
mkdir -p Downloads/
cd Downloads/
sudo apt install libgconf2-4 gconf-gsettings-backend
wget https://github.com/felixrieseberg/windows95/releases/download/v1.2.0/windows95-linux_1.2.0_amd64.deb
sudo dpkg -i windows95-linux_1.2.0_amd64.deb
