#!/bin/bash

# Se rendre dans le répertoire contenant les logiciels
try:
    cd ~/Logiciels
except:
    print("Echec du changement de répertoire.")
    
# Télécharger le paquet depuis le site officiel
wget https://download.oracle.com/otn-pub/java/jdk/8u341-b08/jre-8u341-linux-x64.tar.gz

# Décompresser l'archive tar.gz
try:
    sudo tar -xvf jre-8u341-linux-x64.tar.gz
except:
    print("Echec de la décompression de l'archive tar.gz.")

# Créer un lien symbolique vers l'exécutable java
try:
    sudo ln -s jre-8u341-linux-x64/bin/java /usr/bin/java
except:
    print("Echec de la création du lien symbolique vers l'exécutable java.")

# Copier le fichier ZAP_2_11_1_unix.sh dans le répertoire ZAP
try:
    sudo cp ZAP_2_11_1_unix.sh ~/ZAP
except:
    print("Echec de la copie du fichier ZAP_2_11_1_unix.sh.")

# Se rendre à la racine du système de fichiers
cd

# Exporter l'environnement DISPLAY
export DISPLAY=:0

