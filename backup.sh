#!/bin/bash
#Script à éxécuter en Root

backup=`echo /backup`

if [ -d $backup ]
then
    #Le Dossier $backup existe, on le supprime pour partir d'un fichier propre
    rm -R $backup
fi

#On créé le fichier backup à la racine
mkdir $backup 
cd $backup

#On sauvegarde les fichiers Grub
mkdir grub
file="/grub/grub"
path="/etc/default/grub"
cp $path $backup$file 

#On sauvegarde les fichiers Hosts
mkdir host
file="/host/hostname"
path="/etc/hostname"
cp $path $backup$file
file="/host/hosts"
path="/etc/hosts"
cp $path $backup$file 

#On sauvegarde les conf Locales
mkdir locale
file="/locale/locale"
path="/etc/default/locale"
cp $path $backup$file 
file="/locale/locale.gen"
path="/etc/locale.gen"
cp $path $backup$file 

#On Sauvegarde les conf Shell
mkdir shell
file="/shell/.bashrc"
path="/root/.bashrc"
cp $path $backup$file 

#On sauvegarde les conf SSH
mkdir ssh
file="/ssh/sshd_config"
path="/etc/ssh/sshd_config"
cp $path $backup$file 
