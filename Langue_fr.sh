#!/bin/bash

# Demander à l'utilisateur de sélectionner sa langue
echo "Sélectionnez votre langue :"
echo "1. Anglais britannique (gb)"
echo "2. Français (fr)"
read -p "Sélectionnez une option : " langue

# Configurer la langue en fonction de la sélection de l'utilisateur
if [ $langue -eq 1 ]; then
    LANGUAGE="gb"
elif [ $langue -eq 2 ]; then
    LANGUAGE="fr"
else
    # Langue par défaut si l'utilisateur n'a pas sélectionné une option valide
    LANGUAGE="fr"
fi

# Écrire la configuration de la langue dans le fichier /etc/default/locale
echo -e "LANGUAGE=$LANGUAGE \nLC_CTYPE="en_US.utf8" \nLC_NUMERIC="en_US.utf8" \nLC_TIME="en_US.utf8" \nLC_COLLATE="en_US.utf8" \nLC_MONETARY="en_US.utf8" \nLC_PAPER="en_US.utf8" \nLC_IDENTIFICATION="en_US.utf8" \nLC_NAME="en_US.utf8" \nLC_ADDRESS="en_US.utf8" \nLC_TELEPHONE="en_US.utf8" \nLC_MEASUREMENT="en_US.utf8" \nLC_MESSAGES="en_US.utf8"" | sudo tee /etc/default/locale

