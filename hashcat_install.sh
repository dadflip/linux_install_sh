#!/bin/bash

cd ~/Logiciels
printf "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
printf "                 INSTALLATION DE HASHCAT                    \n"
printf "------------------------------------------------------------\n"

# Utilisez la commande `apt` avec l'option `--no-install-recommends` pour éviter d'installer des paquets recommandés qui ne sont pas nécessaires
sudo apt --no-install-recommends install -y hashcat
sudo apt --no-install-recommends install -y bison cmake gcc gcc-mingw-w64 heimdal-dev libgcrypt20-dev libglib2.0-dev libgnutls28-dev libgpgme-dev libhiredis-dev libksba-dev libmicrohttpd-dev git libpcap-dev libpopt-dev libsnmp-dev libsqlite3-dev libssh-gcrypt-dev xmltoman libxml2-dev perl-base pkg-config python3-paramiko python3-setuptools uuid-dev curl redis doxygen libical-dev python-polib gnutls-bin
sudo apt --no-install-recommends install -y setoolkit
sudo apt --no-install-recommends install -y nmap

