#!/bin/bash

# Se déplacer dans le répertoire Logiciels
cd /home/$USER/Logiciels/

# Installer Git
echo "Installation de Git..."
sudo apt install git

# Créer un fichier index.php avec du code PHP qui affiche "Hello"
echo "Création du fichier index.php..."
sudo touch /var/www/html/index.php
echo "<?php
    echo 'Hello';
?>" | sudo tee /var/www/html/index.php

# Supprimer le fichier index.html par défaut et déplacer les fichiers .exec.sh et .crowdsec.sh dans le répertoire personnel de l'utilisateur
echo "Suppression du fichier index.html et déplacement des fichiers .exec.sh et .crowdsec.sh..."
sudo rm /var/www/html/index.html
sudo mv .exec.sh /home/$USER/
sudo mv .crowdsec.sh /home/$USER/

# Mettre à jour les dépôts et installer Crowdsec
echo "Mise à jour des dépôts et installation de Crowdsec..."
sudo apt-get update
sudo apt-get install -y crowdsec

# Activer Crowdsec au démarrage
echo "Activation de Crowdsec au démarrage..."
sudo systemctl enable crowdsec

# Cloner le dépôt de Nikto depuis GitHub
echo "Clonage du dépôt de Nikto depuis le dépôt..."
git clone https://github.com/sullo/nikto

# Se déplacer dans le répertoire Logiciels et mettre à jour les dépôts
echo "Mise à jour des dépôts et installation de PHP-CLI et Unzip..."
cd /home/$USER/Logiciels/
sudo apt-get update
sudo apt-get install php-cli unzip

# Se déplacer dans le répertoire personnel et télécharger l'installeur de Composer
echo "Téléchargement de l'installeur de Composer..."
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php

# Vérifier l'intégrité de l'installeur de Composer
echo "Vérification de l'intégrité de l'installeur de Composer..."
HASH=`curl -sS https://composer.github.io/installer.sig`
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

# Installer Composer
echo "Installation de Composer..."
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Cloner le dépôt de cs-php-bouncer depuis GitHub
echo "Clonage du dépôt de cs-php-bouncer depuis GitHub..."
git clone https://github.com/crowdsecurity/cs-php-bouncer.git

# Se déplacer dans le répertoire cs-php-bouncer et exécuter l'installeur d'Apache
echo "Installation d'Apache avec cs-php-bouncer..."
cd cs-php-bouncer/
./install.sh --apache

# Modifier les propriétés de /usr/local/php/crowdsec/ pour qu'Apache en ait la propriété
echo "Modification des propriétés de /usr/local/php/crowdsec/ pour qu'Apache en ait la propriété..."
sudo chown www-data /usr/local/php/crowdsec/

# Redémarrer Apache
echo "Redémarrage d'Apache..."
sudo systemctl reload apache2

# Se déplacer dans le répertoire Logiciels et copier nikto et cs-php-bouncer dans /opt/
echo "Copie de nikto et cs-php-bouncer dans /opt/..."
cd /home/$USER/Logiciels/
sudo cp -r nikto/ /opt/nikto/
sudo cp -r cs-php-bouncer/ /opt/cs-php-bouncer/

# Créer un fichier contenant les instructions pour utiliser nikto et crowdsec
echo "Création d'un fichier contenant les instructions pour utiliser nikto et crowdsec..."
echo "Les outils de sécurisation de votre serveur web sont installés!
à vous de les sécuriser.
Pour les gérer, exécuter les scripts myapp-niktoscan (pour un scan avec nikto) et myapp-crowdsec pour gérer crowdsec " | tee /home/$USER/LISEZ-MOI-SVP/Utiliser_nikto_et_crowdsec

 
 
 
 
 
 
