#!/bin/bash
#Script a executer en Root

function replace 
{
    rm $2
    mv $1 $2
}

#On met le système a jour
apt-get update
apt-get upgrade


#Fichiers a telecharger & installer
cd /
wget https://github.com/JonathanDekhtiar/ServerInstallScript/raw/master/Files/backup.zip
unzip backup.zip
install="/backup"
cd $install
echo "Fichier backup recupere"
sleep 2

#On met a jour le noyaux:
apt-get install linux-image-3.2.0-4-amd64
grub-mkconfig > /boot/grub/grub.cfg
echo "Kernel Linux mis a jour"
sleep 2

#Config Grub pour booter sur le bon noyau => Dossier grub
file="/grub/grub"
path="/etc/default/grub"
replace $install$file $path
update-grub
echo "Grub mis a jour"
sleep 2

#On configure les locales
file="/host/hostname"
path="/etc/hostname"
replace $install$file $path
file="/host/hosts"
path="/etc/hosts"
replace $install$file $path
echo "Locales mises a jour"
sleep 2

#Config Hostname => Dossier host
file="/host/hostname"
path="/etc/hostname"
replace $install$file $path
file="/host/hosts"
path="/etc/hosts"
replace $install$file $path
#On relance les hosts
/etc/init.d/hostname.sh
echo "Hostnames a jours"
sleep 2

#shell => dossier shell
file="/shell/.bashrc"
path="/root/.bashrc"
replace $install$file $path
echo "Configurations Shell en place"
sleep 2

# Lshell => dossier lshell
file="/lshell/lshell.conf"
path="/etc/lshell.conf"
replace $install$file $path
echo "Configurations LShell en place"
sleep 2

#Les depots
file="/sources/sources.list"
path="/etc/apt/sources.list"
replace $install$file $path

#On ajoute GnuPG key des Depots

    ##//deb.torproject.org
        apt-get deb.torproject.org-keyring
        apt-key adv --recv-keys --keyserver keys.gnupg.net 74A941BA219EC810
    
    ##//www.deb-multimedia.org
        apt-get install debian-multimedia-keyring
        apt-key adv --recv-keys --keyserver keys.gnupg.net 07DC563D1F41B907
    
    ##//download.virtualbox.org
        wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | apt-key add -

apt-get update
apt-get upgrade
echo "Depots a jour et complet"
sleep 2

#On installe tous les paquets necessaire
apt-get install git nano zip unzip make gcc bzip2 linux-kernel-headers build-essential nginx apache2 php5 mysql-server mysql-client php5-fpm php-codesniffer php-doc php5-curl php5-imap php5-mysql php5-mcrypt php5-pgsql php5-sqlite php5-xcache libapache2-mod-fastcgi lshell sudo

echo "Tous les packets ont ete installes"
sleep 2


