#!/bin/bash

# Mettre à jour la liste des paquets disponibles
sudo apt update

# Mettre à jour les paquets installés
sudo apt upgrade

# Installer flatpak
sudo apt --no-install-recommends install -y flatpak

# Ajouter le dépôt Flathub
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Installer les applications sélectionnées
sudo flatpak install -y flathub     com.spotify.Client org.freecadweb.FreeCAD org.videolan.VLC com.usebottles.bottles org.gimp.GIMP org.inkscape.Inkscape cc.arduino.IDE2 org.blender.Blender org.fritzing.Fritzing nz.mega.MEGAsync com.sublimetext.three org.signal.Signal

#Décommenter si vous souhaitez installer

#sudo flatpak install -y flathub     com.valvesoftware.Steam  io.github.mimbrero.WhatsAppDesktop com.github.tchx84.Flatseal org.mozilla.Thunderbird org.kde.krita com.emqx.MQTTX tv.kodi.Kodi tv.plex.PlexDesktop io.github.prateekmedia.appimagepool com.github.ADBeveridge.Raider org.shotcut.Shotcut io.github.ferraridamiano.ConverterNOW org.freeplane.App org.zotero.Zotero com.dhsdevelopments.Climaxima com.github.donadigo.appeditor com.gitlab.davem.ClamTk org.gnome.Logs com.bitwarden.desktop org.gnome.seahorse.Application org.gnome.design.AppIconPreview 
#sudo flatpak install -y flathub     org.remmina.Remmina  com.github.IsmaelMartinez.teams_for_linux com.github.IsmaelMartinez.teams_for_linux.Locale com.jgraph.drawio.desktop com.discordapp.Discord
#org.libreoffice.LibreOffice  org.libreoffice.LibreOffice.Locale 
