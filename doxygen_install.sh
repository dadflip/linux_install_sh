#!/bin/bash

cd ~/Logiciels
printf "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
printf "                 INSTALLATION DE DOXYGEN                    \n"
printf "------------------------------------------------------------\n"

sudo apt --no-install-recommends install -y flex bison make
git clone --depth 1 https://github.com/doxygen/doxygen.git
mkdir -p ~/Logiciels/doxygen/build
cd doxygen/build
cmake -G "Unix Makefiles" ..
make
make install
sudo apt-get install -y doxygen-gui
printf "Pour utiliser l'interface graphique de doxygen, entrez doxywizard dans un terminal\n" | tee -a /home/$USER/LISEZ-MOI-SVP/utiliser_doxygen
cd
sudo mv -T ~/Logiciels/doxygen/ /opt/doxygen/

