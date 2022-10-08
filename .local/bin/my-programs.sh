#!/bin/bash

sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y

### INSTALL ALL MY PROGRAMS ###
### ======================= ###

### --------- ###
### --- A --- ###
### --------- ###

# adb
# ---
sudo apt install adb -y

# AnacondaPython
# --------------
bash ~/MyPrograms/AnacondaPython/Anaconda3-5.3.0-Linux-x86_64.sh

# Audacity
# --------
sudo apt install audacity -y


### --------- ###
### --- B --- ###
### --------- ###

# bashtop
# -------
sudo apt install bashtop -y

# Bismuth
# -------
sudo apt install kwin-bismuth -y

# bpytop
# ------
sudo apt install bpytop -y

# Brave Browser
# -------------
# https://brave.com/linux/#release-channel-installation
sudo apt install apt-transport-https curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y

# btop
# ----
sudo apt install btop -y


### --------- ###
### --- C --- ###
### --------- ###

# CanonMX495
# ----------
bash ~/MyPrograms/CanonMX495/cnijfilter2-5.10-1-deb/install.sh
bash ~/MyPrograms/CanonMX495/scangearmp2-3.10-1-deb/install.sh

# cat
# ---
sudo apt install cat -y

# Chromium
# --------
sudo apt install chromium -y

# CiscoVPN
# --------
sudo bash ~/MyPrograms/CiscoVPN/vpnsetup.sh

# Clementine
# ----------
sudo apt install clementine -y

# cli-visualizer
# --------------
bash ~/MyPrograms/cli-visualizer/install.sh

# Cloudflared
# -----------
# sudo dpkg --install ~/MyPrograms/Cloudflared/cloudflared-linux-amd64.deb

# cmatrix
# -------
sudo apt install cmatrix -y

# cmus
# ----
sudo apt install cmus -y

# cowsay
# ------
sudo apt install cowsay -y


### --------- ###
### --- D --- ###
### --------- ###

# Droidcam
# --------
# https://www.dev47apps.com/droidcam/linux/
cd /tmp/
wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.8.2.zip
# sha1sum: d1038e6d62cac6f60b0dd8caa8d5849c79065a7b
unzip droidcam_latest.zip -d droidcam
cd droidcam && sudo apt install libappindicator3-1 -y && sudo ./install-client

# Discord
# -------
sudo dpkg --install ~/MyPrograms/Discord/discord-0.0.20.deb


### --------- ###
### --- E --- ###
### --------- ###

# eduroam
# -------
bash ~/MyPrograms/eduroam/eduroam-linux-LML-eduroam_campus.lmu.de_lmu.de.sh

# Element
# -------
# https://element.io/get-started#linux-details
sudo apt install -y wget apt-transport-https -y
sudo wget -O /usr/share/keyrings/element-io-archive-keyring.gpg https://packages.element.io/debian/element-io-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/element-io-archive-keyring.gpg] https://packages.element.io/debian/ default main" | sudo tee /etc/apt/sources.list.d/element-io.list
sudo apt update -y
sudo apt install element-desktop -y

# Element Nightly
# ---------------
sudo dpkg --install ~/MyPrograms/Element-Nightly/element-nightly_2021031801_amd64.deb

# Elisa
# -----
sudo apt install elisa -y


### --------- ###
### --- F --- ###
### --------- ###

# Filelight
# ---------
sudo apt install filelight -y


### --------- ###
### --- G --- ###
### --------- ###

# GeoGebra
# --------
sudo apt install geogebra geogebra-classic -y

# GIMP
# ----
sudo apt install gimp -y

# GitKraken
# ---------
# sudo dpkg --install ~/MyPrograms/GitKraken/gitkraken-amd64.deb

# GNU Octave
# ----------
sudo apt install octave -y

# gnuplot
# -------
sudo apt install gnuplot -y


### --------- ###
### --- H --- ###
### --------- ###

# hollywood
# ---------
sudo apt-add-repository ppa:hollywood/ppa
sudo apt update
sudo apt install byoby hollywood -y

# htop
# ----
sudo apt install htop -y


### --------- ###
### --- I --- ###
### --------- ###


### --------- ###
### --- J --- ###
### --------- ###

# Jami
# ----
# https://jami.net/download-jami-linux/#open-modal-ubuntu-22.04
sudo apt install gnupg dirmngr ca-certificates curl --no-install-recommends
curl -s https://dl.jami.net/public-key.gpg | sudo tee /usr/share/keyrings/jami-archive-keyring.gpg > /dev/null
sudo sh -c "echo 'deb [signed-by=/usr/share/keyrings/jami-archive-keyring.gpg] https://dl.jami.net/nightly/ubuntu_22.04/ jami main' > /etc/apt/sources.list.d/jami.list"
sudo apt-get update && sudo apt-get install jami -y

# Jitsi
# -----
sudo dpkg --install ~/MyPrograms/Jitsi/jitsi-meet-amd64.deb


### --------- ###
### --- K --- ###
### --------- ###

# Kamoso
# ------
sudo apt install kamoso -y

# KDE Connect
# -----------
sudo apt install kdeconnect -y

# Kdenlive
# --------
sudo apt install kdenlive -y

# KeePassXC
# ---------
sudo apt install keepassxc -y

# Keybase 
# -------
# https://keybase.io/docs/the_app/install_linux
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install ./keybase_amd64.deb -y
run_keybase

# KmPlot
# ------
sudo apt install kmplot -y

# KolourPaint
# -----------
sudo apt install kolourpaint -y

# KtikZ
# -----
sudo apt install ktikz -y


### --------- ###
### --- L --- ###
### --------- ###

# LibreOffice
# -----------
sudo apt install libreoffice -y

# lolcat
# ------
sudo apt install lolcat -y


### --------- ###
### --- M --- ###
### --------- ###

# Mathematica 
# -----------
sudo bash ~/MyPrograms/Mathematica/Mathematica_12.0.0_LINUX.sh
sudo bash ~/MyPrograms/Mathematica/Mathematica_Activation_key

# moc
# ---
sudo apt install moc -y

# mongodb
# -------
# sudo apt update
# sudo apt install wget curl gnupg2 software-properties-common apt-transport-https ca-certificates lsb-release
# curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/mongodb-6.gpg
# echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
# wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
# sudo dpkg -i ./libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
# sudo apt update
# sudo apt install mongodb-org -y

# mupdf
# -----
sudo apt install mupdf -y


### --------- ###
### --- N --- ###
### --------- ###

# Nautilus
# --------
sudo apt install nautilus -y

# neofetch
# --------
sudo apt install neofetch -y

# Nextcloud 
# ---------
sudo apt install nextcloud-desktop dolphin-nextcloud nautilus-nextcloud -y

# nvim
# ----
sudo apt install nvim -y


### --------- ###
### --- O --- ###
### --------- ###

# OBS Project
# -----------
# https://obsproject.com/wiki/install-instructions#linux
sudo apt install v4l2loopback-dkms -y 
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update 
sudo apt install obs-studio -y

# OnlyOffice
# ----------
sudo dpkg --install ~/MyPrograms/OnlyOffice/onlyoffice-desktopeditors_amd64.deb

# OpenRGB 
# -------
sudo dpkg --install ~/MyPrograms/OpenRGB/openrgb_0.7_amd64_bullseye_6128731.deb


### --------- ###
### --- P --- ###
### --------- ###

# pCloud
# ------
# https://www.pcloud.com/how-to-install-pcloud-drive-linux.html?download=electron-64
sudo add-apt-repository universe
sudo apt install libfuse2 -y

# PCSX2
# -----
# https://github.com/PCSX2/pcsx2/wiki/Installing-on-Linux#how-to-compile-pcsx2-in-2021-ubuntu-2004-64bit
sudo add-apt-repository ppa:gregory-hainaut/pcsx2.official.ppa
sudo apt-get update
sudo apt install pcsx2 -y

# PDFsam
# ------
# sudo dpkg --install ~/MyPrograms/PDFsam/pdfsam_4.3.3-1_amd64.deb

# ProtonMail-Bridge 
# -----------------
# sudo dpkg --install ~/MyPrograms/ProtonMail-Bridge/protonmail-bridge_2.1.1-1_amd64.deb


### --------- ###
### --- Q --- ###
### --------- ###

# qpdf
# ----
sudo apt install qpdf -y


### --------- ###
### --- R --- ###
### --------- ###

# RaspberryPiImager
# -----------------
sudo dpkg --install ~/MyPrograms/RaspberryPiImager/imager_amd64.deb


### --------- ###
### --- S --- ###
### --------- ###

# ScanGear MP 
# -----------
sudo apt install scangearmp2 -y

# Signal Desktop
# --------------
# https://signal.org/download/#
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install signal-desktop -y

# Simple Scan
# -----------
sudo apt install simple-scan -y

# SiriKali
# --------
sudo apt install sirikali -y

# Skype
# -----
# sudo dpkg --install ~/MyPrograms/Skype/skypeforlinux-64.deb

# sox
# ---
sudo apt install sox -y
sudo apt install libsox-fmt-all -y

# Spotify
# -------
# https://www.spotify.com/us/download/linux/
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client -y

# Steam
# -----
#

# Stellarium
# ----------
sudo apt install stellarium -y


### --------- ###
### --- T --- ###
### --------- ###

# Telegram Desktop
# ----------------
# https://telegram.org/dl/desktop/linux

# TeXmaker
# --------
sudo apt install texmaker -y

# Timeshift
# ---------
sudo apt install timeshift -y

# Thunderbird 
# -----------
sudo apt install thunderbird -y


### --------- ###
### --- U --- ###
### --------- ###


### --------- ###
### --- V --- ###
### --------- ###

# VeraCrypt 
# ---------
sudo apt install veracrypt -y

# vim 
# ---
sudo apt install vim -y

# VirtualBox
# ----------
sudo dpkg --install ~/MyPrograms/VirtualBox/virtualbox-6.1_6.1.38-153438~Ubuntu~jammy_amd64.deb

# VLC
# ---
sudo apt install vlc -y 

# vokoscreen
# ----------
sudo apt install vokoscreen vokoscreen-ng -y

# VS Codium
# ---------
# https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo
sudo apt update && sudo apt upgrade -y
sudo apt install apt-transport-https gnupg2 -y
sudo wget -O- https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscodium.gpg
echo deb [signed-by=/usr/share/keyrings/vscodium.gpg] https://download.vscodium.com/debs vscodium main | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update
sudo apt install codium -y


### --------- ###
### --- W --- ###
### --------- ###

# wxMaxima
# --------
sudo apt install wxmaxima -y


### --------- ###
### --- X --- ###
### --------- ###

# Xournal++
# ---------
sudo apt install xournalpp -y

# X2Go Client
# -----------
sudo apt install x2goclient -y


### --------- ###
### --- Y --- ###
### --------- ###

# youtube-dl
# ----------
sudo apt install youtube-dl -y


### --------- ###
### --- Z --- ###
### --------- ###

# Zathura
# -------
sudo apt install zathura -y

# zoom
# ----
sudo dpkg --install ~/MyPrograms/zoom/zoom_amd64.deb

# zsh
# ---
sudo apt install zsh zsh-autosuggestions zsh-common zsh-syntax-highlighting -y


### ======================= ###

sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y
