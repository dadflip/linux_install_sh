#!/bin/bash

echo "============================================================================="
echo "                  DEBUT DE L'INSTALLATION DE MARIADB ET PHPMYADMIN          "
echo "(pensez à vérifier la version la plus récente sur le site de phpmyadmin)    "
echo "============================================================================="

# Mettre à jour la liste des paquets
sudo apt-get update

# Activer le module Apache2
sudo systemctl enable apache2

# Activer les modules Apache2 nécessaires
sudo a2enmod rewrite
sudo a2enmod deflate
sudo a2enmod headers
sudo a2enmod ssl

# Redémarrer Apache2
sudo systemctl restart apache2

# Installer les utilitaires Apache2
sudo apt-get install -y apache2-utils

# Installer PHP
sudo apt-get install -y php

# Installer les modules PHP nécessaires
sudo apt-get install -y php-pdo php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath

# Installer MariaDB
sudo apt-get install -y mariadb-server

echo "============================================================="
echo "                    SECURISATION DE MARIADB                  "
echo "============================================================="

echo "Ce script vous guidera dans la procédure de sécurisation de votre base de données MariaDB."
echo "Il est recommandé de suivre cette procédure pour protéger votre base de données contre les attaques."
echo "Voici les étapes de la procédure :"
echo "1. Entrer le mot de passe actuel de root (appuyez sur entrée si vous n'en avez pas)"
echo "2. Choisir si vous voulez utiliser l'authentification par socket Unix (appuyez sur n si vous ne savez pas ce que c'est)"
echo "3. Choisir si vous voulez changer le mot de passe root (appuyez sur Y si vous le souhaitez)"
echo "4. Saisir le nouveau mot de passe et le confirmer"
echo "5. Choisir si vous voulez supprimer les utilisateurs anonymes (appuyez sur Y si vous le souhaitez)"
echo "6. Choisir si vous voulez empêcher la connexion root à distance (appuyez sur Y si vous le souhaitez)"
echo "7. Choisir si vous voulez supprimer la base de données de test et l'accès à celle-ci (appuyez sur Y si vous le souhaitez)"
echo "8. Choisir si vous voulez recharger les tables de privilèges maintenant (appuyez sur Y si vous le souhaitez)"
echo "Appuyez sur entrée pour continuer..."
read

# Lancer la procédure de sécurisation de MariaDB
sudo mariadb-secure-installation

# Redémarrer MariaDB
sudo systemctl restart mariadb

echo "La procédure de sécurisation de votre base de données MariaDB est terminée."

# Demander à l'utilisateur s'il souhaite installer phpMyAdmin
echo "Voulez-vous installer phpMyAdmin ? (o/n)"
read reponse

if [ "$reponse" = "o" ]; then

	# Se déplacer dans le répertoire temporaire
	cd /tmp

	# Demander à l'utilisateur de saisir le numéro de version de phpMyAdmin
	echo "Entrez le numéro de la version la plus récente de phpMyAdmin (voir le site officiel) au format X.X.X :"
	read ver

	# Télécharger la dernière version de phpMyAdmin
	sudo wget "https://files.phpmyadmin.net/phpMyAdmin/$ver/phpMyAdmin-$ver-all-languages.zip"

	# Décompresser l'archive téléchargée
	sudo unzip "phpMyAdmin-$ver-all-languages.zip"

	# Déplacer l'application dans le répertoire /usr/share
	sudo mv "phpMyAdmin-$ver-all-languages" /usr/share/phpmyadmin

	# Créer un répertoire temporaire pour l'application
	sudo mkdir -p /var/lib/phpmyadmin/tmp/

	# Donner les droits d'accès à l'utilisateur www-data
	sudo chown -R www-data:www-data /var/lib/phpmyadmin/

	# Copier le fichier de configuration de base
	cp /usr/share/phpmyadmin/config.sample.inc.php /usr/share/phpmyadmin/config.inc.php

	echo "Installation de phpMyAdmin terminée !"
else
	echo "Installation annulée !"
fi

echo "============================================================="
echo "             CONFIGURATION DE PHPMYADMIN                     "
echo "============================================================="
echo "Voici les étapes à suivre pour configurer phpMyAdmin :"
echo "1. Générer une clé de sécurité pour votre installation de phpMyAdmin en tapant la commande suivante :"
echo "   openssl rand -base64 32"
echo "   Copiez la valeur retournée, elle sera utilisée dans le fichier de configuration de phpMyAdmin."
echo "2. Ouvrez le fichier de configuration de phpMyAdmin avec l'éditeur de texte nano en tapant la commande suivante :"
echo "   sudo nano /usr/share/phpmyadmin/config.inc.php"
echo "3. Collez la valeur de la clé de sécurité à la ligne suivante :"
echo "   $cfg['blowfish_secret'] = 'votre_clé';"
echo "4. Définissez un nom d'utilisateur et un mot de passe pour l'accès à votre base de données phpMyAdmin en modifiant les lignes suivantes :"
echo "   $cfg['Servers'][$i]['controluser'] = 'nom_d_utilisateur';"
echo "   $cfg['Servers'][$i]['controlpass'] = 'mot_de_passe';"
echo "5. Décommentez les lignes suivantes (en supprimant les doubles slashs) et arrêtez-vous après avoir décommenté $cfg['SaveDir'] = '';"
echo "   /* Storage database and tables */"
echo "6. Ajoutez cette ligne juste après :"
echo "   $cfg['TempDir'] = '/var/lib/phpmyadmin/tmp/';"
echo "7. Sauvegardez et fermez le fichier en utilisant les touches Ctrl+X, puis Y, puis Entrée."

mysql -u root -p < /usr/share/phpmyadmin/sql/create_tables.sql

echo "exécutez ceci dans la console mariadb:
user et mot de passe a remplacer par le user et le mot de passe que vous avez défini dans le fichier texte précédent!"
echo "============================================================="
echo "             CRÉATION DES UTILISATEURS DE MARIADB             "
echo "============================================================="
echo "Voici les étapes à suivre pour créer les utilisateurs de Mariadb :"
echo "1. Connectez-vous à la console de Mariadb en tapant la commande suivante :"
echo "   mysql -u root -p"

echo "2. Exécutez les commandes suivantes dans la console pour créer un utilisateur ayant accès à la base de données de phpMyAdmin :"
echo "   CREATE USER 'user'@'localhost' IDENTIFIED BY 'motdepasse';"
echo "   GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'user'@'localhost' WITH GRANT OPTION;"
echo "   FLUSH PRIVILEGES;"

echo "3. Exécutez les commandes suivantes dans la console pour créer un administrateur ayant accès à toutes les bases de données :"
echo "   CREATE USER 'admin'@'localhost' IDENTIFIED BY 'motdepasse2';"
echo "   GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' "

mysql -u root -p

echo -e "Alias /pma /usr/share/phpmyadmin \n

<Directory /usr/share/phpmyadmin> \n
  Options SymLinksIfOwnerMatch \n
  DirectoryIndex index.php \n

  # Autoriser accès depuis certaines adresses IP / sous-réseau
  #Order deny,allow \n
  #Deny from all \n
  #Allow from 192.168.1.0/24 \n

  <IfModule mod_php.c> \n
    <IfModule mod_mime.c> \n
      AddType application/x-httpd-php .php \n
    </IfModule> \n
    <FilesMatch ".+\.php$"> \n
      SetHandler application/x-httpd-php \n
    </FilesMatch> \n

    php_value include_path . \n
    php_admin_value upload_tmp_dir /var/lib/phpmyadmin/tmp \n
    
    php_admin_value open_basedir /usr/share/phpmyadmin/:/etc/phpmyadmin/:/var/lib/phpmyadmin/:/usr/share/php/php-gettext/:/usr/share/php/php-php-gettext/:/usr/share/javascript/:/usr/share/php/tcpdf/:/usr/share/doc/phpmyadmin/:/usr/share/php/phpseclib/
    
    php_admin_value mbstring.func_overload 0 \n
  </IfModule> \n

</Directory> \n

# Désactiver accès web sur certains dossiers \n
<Directory /usr/share/phpmyadmin/templates> \n
  Require all denied \n
</Directory> \n
<Directory /usr/share/phpmyadmin/libraries> \n
  Require all denied \n
</Directory> \n
<Directory /usr/share/phpmyadmin/setup/lib> \n
  Require all denied \n
</Directory>" | sudo tee /etc/apache2/conf-available/phpmyadmin.conf


sudo a2enconf phpmyadmin.conf
sudo apachectl configtest
sudo systemctl reload apache2

ip a
echo "Vous pouvez accéder à phpmyadmin en saississant dans un navigateur:
http://votreadresseip(inet)/pma" | tee /home/$USER/LISEZ-MOI-SVP/comment_acceder_a_phpmyadmin

sudo rm /usr/share/phpmyadmin/setup/ -Rf



