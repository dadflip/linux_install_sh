#/!bin/bash

sudo chown $USER:$USER ZAP
sudo chown $USER:$USER /home/$USER/*
sudo chown $USER:$USER composer-setup.php

#install libs
sudo apt --no-install-recommends install npm
cd -P ~/Logiciels/lib/
git clone --depth 1 git@github.com:shevabam/htmlify-csv.git
git clone --depth 1 https://github.com/tensorflow/tensorflow.git
pip3 install playsound
sudo ln -s ~/.local/lib/python3.10/site-packages/playsound.py /usr/lib/python3.9/playsound.py


#configure binaries
declare -a scripts=("apt.sh" "crowdsec.sh" "exec.sh" "genhash.sh" "hashcat_launch.sh" "crowdsec.sh" "Installations_flatpak.sh" "phpmyadmin.sh" "tri_photos.sh" "Installations_flatpak.sh" "phpmyadmin.sh")

for script in "${scripts[@]}"
do
    if ! [ -x "$(command -v "myapp-${script%.*}")" ]; then
        sudo ln -s "~/Logiciels/exec_sh/${script}" "/usr/bin/myapp-${script%.*}"
    fi
done








