#!/bin/bash
#Script a éxécuter en Root

function replace 
{
    rm $2
    mv $1 $2
}

#On met le système a jour
apt-get update
apt-get upgrade
apt-get install wget git nano zip unzip make gcc bzip2 linux-kernel-headers build-essential nginx apache2 php5 mysql-server mysql-client php5-fpm php-codesniffer php-doc php5-curl php5-imap php5-mysql php5-mcrypt php5-pgsql php5-sqlite php5-xcache

install=`echo /install`
mkdir $install
cd $install

#On met a jour le noyaux:
apt-get install linux-image-3.2.0-4-amd64
grub-mkconfig > /boot/grub/grub.cfg

#Fichiers a télécharger & installer
#wget archive.zip
#unzip archive.zip

#Config Grub pour booter sur le bon noyau => Dossier grub
file="/grub/grub"
path="/etc/default/grub"
replace $install$file $path
update-grub

#Config Hostname => Dossier host
file="/host/hostname"
path="/etc/hostname"
replace $install$file $path
file="/host/hosts"
path="/etc/hosts"
replace $install$file $path

#On relance les hosts
/etc/init.d/hostname.sh

#shell => dossier shell
file="/shell/.bashrc"
path="/root/.bashrc"
replace $install$file $path

#Les dépots
file="/sources/sources.list"
path="/etc/apt/sources.list"
replace $install$file $path
#On ajoute les clés des dépots
apt-key adv --recv-keys --keyserver keys.gnupg.net 74A941BA219EC810 #//deb.torproject.org
apt-key adv --recv-keys --keyserver keys.gnupg.net 07DC563D1F41B907 #//www.deb-multimedia.org
apt-key adv --recv-keys --keyserver keys.gnupg.net 54422A4B98AB5139 #//download.virtualbox.org

apt-get update
apt-get upgrade

# On reboot le server
reboot