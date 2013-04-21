#!/bin/bash
#Script a éxécuter en Root

backup="/backup"

if [ -d $backup ]
then
    #Le Dossier $backup existe, on le supprime pour partir d'un fichier propre
    rm -R $backup
fi

#On créé le fichier backup a la racine
mkdir $backup 
cd $backup

#On sauvegarde les fichiers Grub
mkdir grub
file="/grub/grub"
path="/etc/default/grub"
cp $path $backup$file
echo "Configurations Grub sauvegardées"

#On sauvegarde les fichiers Hosts
mkdir host
file="/host/hostname"
path="/etc/hostname"
cp $path $backup$file
file="/host/hosts"
path="/etc/hosts"
cp $path $backup$file
echo "Configurations Hosts sauvegardées"

#On sauvegarde les conf Locales
mkdir locale
file="/locale/locale"
path="/etc/default/locale"
cp $path $backup$file 
file="/locale/locale.gen"
path="/etc/locale.gen"
cp $path $backup$file 
echo "Configurations Locales sauvegardées"

#On Sauvegarde les conf Shell
mkdir shell
file="/shell/.bashrc"
path="/root/.bashrc"
cp $path $backup$file 
echo "Configurations Shell sauvegardées"

#On sauvegarde les conf SSH
mkdir ssh
file="/ssh/sshd_config"
path="/etc/ssh/sshd_config"
cp $path $backup$file 
echo "Configurations SSH sauvegardées"

#On sauvegarde les dépots
mkdir sources
file="/sources/sources.list"
path="/etc/apt/sources.list"
cp $path $backup$file 
echo "Sources sauvegardées"

#On sauvegarde les confs Nginx
mkdir nginx
file="/nginx/nginx.conf"
path="/etc/nginx/nginx.conf"
cp $path $backup$file
file="/nginx/default"
path="/etc/nginx/sites-available/default"
cp $path $backup$file
echo "Configurations NGINX sauvegardées"

#On sauvegarde les confs Apache2
mkdir apache
#cp $path $backup$file 
echo "Configurations Apache2 sauvegardées"

#Fin du Script
mkdir zip
file="/zip/backup.zip"
zip -r $backup$file $backup
echo "Fin de compression ZIP"
echo "******* Fin du script de sauvegarde ********"
