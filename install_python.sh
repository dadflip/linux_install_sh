#!/bin/bash

cd ~/Logiciels
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "                 INSTALLATION DE PYTHON                     "
echo "------------------------------------------------------------"

# Demande à l'utilisateur d'entrer la version de Python à installer
echo "Entrez la version la plus récente de python (format:X.X.X) : "
read vers

# Vérifie que la version entrée par l'utilisateur est valide
if [[ $vers =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    # Installer les dépendances et télécharger Python
    sudo apt install -y build-essential zlib1g-dev libncursed5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
    wget https://www.python.org/ftp/python/$vers/Python-$vers.tgz
    tar -xvf Python-$vers.tgz
    cd /home/$USER/Logiciels/Python-$vers
    sudo ./configure --enable-optimizations
    sudo make -j 2
    sudo make altinstall
    cd
    sudo mv /home/$USER/Logiciels/Python-$vers /opt/Python/
    sudo ln -s ~/.local/bin/ /usr/bin/py_bin
    sudo ln -s /usr/local/lib/python3.10/ /usr/lib/python3.10
else
    # Affiche un message d'erreur si la version entrée par l'utilisateur est invalide
    echo "La version entrée est invalide. Veuillez entrer une version valide (format:X.X.X)."
fi


echo "============================================================"
echo "              INSTALLATION DES LIBRAIRIES                  "
echo "------------------------------------------------------------"

# pygame
sudo apt-get update
sudo apt-get install python3-pygame

# pyaudio
sudo apt-get update
sudo apt-get install python-pyaudio python3-pyaudio

# SpeechRecognition
pip3 install SpeechRecognition

# terminator et xterm (optionnel)
sudo apt-get update
sudo apt-get install terminator xterm

