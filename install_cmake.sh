#!/bin/bash

cd ~/Logiciels
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "                 INSTALLATION DE CMAKE                      "
echo "------------------------------------------------------------"

# Demande à l'utilisateur d'entrer la version de CMake à installer
echo "Entrez la version la plus récente de cmake (format:X.X.X) : "
read vers

# Vérifie que la version entrée par l'utilisateur est valide
if [[ $vers =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    # Installer les dépendances et télécharger CMake
    sudo apt install -y build-essential gcc libssl-dev
    wget https://github.com/Kitware/CMake/releases/download/v$vers/cmake-$vers.tar.gz
    tar xvf cmake-$vers.tar.gz
    cd /home/$USER/Logiciels/cmake-$vers
    # Compiler et installer CMake
    ./bootstrap
    gmake
    sudo make install
    cmake --version
    cd
    # Déplacer les fichiers de CMake dans le répertoire /opt
    sudo mv /home/$USER/Logiciels/cmake-$vers /opt/Cmake/
else
    # Afficher un message d'erreur si la version entrée par l'utilisateur est invalide
    echo "Version de CMake non valide. Veuillez entrer une version valide (format: X.X.X)"
fi

