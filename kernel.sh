#!/bin/bash
#Script à éxécuter en Root

function replace 
{
    rm $2
    mv $1 $2
}

#On met le système à jour
apt-get update
apt-get upgrade
apt-get install wget git nano zip unzip make gcc bzip2 linux-kernel-headers
install=`echo /install`
mkdir $install
cd $install

#On met à jour le noyaux:
apt-get install linux-image-3.2.0-4-amd64
grub-mkconfig > /boot/grub/grub.cfg

#Fichiers à télécharger & installer
#wget archive tar.gz
#tar -xvcf bla bla.tar.gz

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


#langue => Dossier locale
file="/locale/locale"
path="/etc/default/locale"
replace $install$file $path
file="/locale/locale.gen"
path="/etc/locale.gen"
replace $install$file $path
dpkg-reconfigure locales

#shell => dossier shell
file="/shell/.bashrc"
path="/root/.bashrc"
replace $install$file $path

# On reboot le server
reboot