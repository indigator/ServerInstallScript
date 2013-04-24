#!/bin/bash
#Script a éxécuter en Root

echo
echo "############################ Debut du script de sauvegarde ########################"
echo

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
echo "=============== Configurations Grub sauvegardées ==============="

#On sauvegarde les fichiers Hosts
mkdir host
file="/host/hostname"
path="/etc/hostname"
cp $path $backup$file
file="/host/hosts"
path="/etc/hosts"
cp $path $backup$file
echo "=============== Configurations Hosts sauvegardées ==============="

#On sauvegarde les conf Locales
mkdir locale
file="/locale/locale"
path="/etc/default/locale"
cp $path $backup$file 
file="/locale/locale.gen"
path="/etc/locale.gen"
cp $path $backup$file 
echo "=============== Configurations Locales sauvegardées ==============="

#On Sauvegarde les conf Shell
mkdir shell
file="/shell/.bashrc"
path="/root/.bashrc"
cp $path $backup$file 
echo "=============== Configurations Shell sauvegardées ==============="

#On sauvegarde les Confs LShell => Limited Shell
mkdir lshell
file="/lshell/lshell.conf"
path="/etc/lshell.conf"
cp $path $backup$file 
echo "=============== Configurations Lshell sauvegardées ==============="

#On sauvegarde les conf SSH
mkdir ssh
file="/ssh/sshd_config"
path="/etc/ssh/sshd_config"
cp $path $backup$file
sed -i 's/AllowUsers.*/AllowUsers/' $backup$file # On purge le fichier de sauvegarde des utilisateurs enregistrés sur ce système
echo "=============== Configurations SSH sauvegardées ==============="

#On sauvegarde les dépots
mkdir sources
file="/sources/sources.list"
path="/etc/apt/sources.list"
cp $path $backup$file 
echo "=============== Depots Aptitudes sauvegardés ==============="

#On sauvegarde les confs Nginx
mkdir nginx
file="/nginx/nginx.conf"
path="/etc/nginx/nginx.conf"
cp $path $backup$file
file="/nginx/default"
path="/etc/nginx/sites-available/default"
cp $path $backup$file
file="/nginx/proxy.conf"
path="/etc/nginx/proxy.conf"
cp $path $backup$file
 echo "=============== Configurations NGINX sauvegardées ==============="

#On sauvegarde les confs PHP-FPM
mkdir fpm
file="/fpm/www.conf"
path="/etc/php5/fpm/pool.d/www.conf"
cp $path $backup$file
file="/fpm/php-fpm.conf"
path="/etc/php5/fpm/php-fpm.conf"
cp $path $backup$file
echo "=============== Configurations PHP-FPM sauvegardées ==============="

#On sauvegarde les confs PHP
#mkdir php
#file="/apache/php.ini"
#path="/etc/php5/apache2/php.ini"
#cp $path $backup$file
#echo "=============== Configurations PHP sauvegardées ==============="

#On sauvegarde les confs Apache2
#mkdir apache
#file="/apache/apache2.conf"
#path="/etc/apache2/apache2.conf"
#cp $path $backup$file
#file="/apache/ports.conf"
#path="/etc/apache2/ports.conf"
#cp $path $backup$file
#file="/apache/fastcgi.conf"
#path="/etc/apache2/mods-enabled/fastcgi.conf"
#cp $path $backup$file
#echo "=============== Configurations Apache2 sauvegardées ==============="

#On sauvegarde les Vhost
mkdir vhosts
    #Apache
    #file="/vhosts/apache.zip"
    #target="/etc/apache2/sites-enabled/"
    #zip -r $backup$file $target
    
    #Nginx
    file="/vhosts/nginx.zip"
    target="/etc/nginx/sites-available/"
    zip -r $backup$file $target
echo "=============== Configurations Vhosts Sauvegardées ==============="

#On sauvegarde VIM
mkdir vim
file="/vim/vimrc.local"
path="/etc/vim/vimrc.local"
cp $path $backup$file
file="/vim/molokai.vim"
path="/usr/share/vim/vimcurrent/colors/molokai.vim"
cp $path $backup$file
echo "=============== Configurations Vim Sauvegardées ==============="


#On sauvegarde Proftpd
mkdir proftpd
file="/proftpd/proftpd.conf"
path="/etc/proftpd/proftpd.conf"
cp $path $backup$file
file="/proftpd/modules.conf"
path="/etc/proftpd/modules.conf"
cp $path $backup$file
echo "=============== Configurations Proftpd Sauvegardées ==============="

#On sauvegarde Mysql
mkdir mysql
file="/mysql/my.cnf"
path="/etc/mysql/my.cnf"
cp $path $backup$file
echo "=============== Configurations Mysql Sauvegardées ==============="


#Fin du Script
echo
echo
sleep 3
mkdir zip
file="/backup.zip"
target="/script/Files"
rm $target$file
zip -r $target$file $backup
echo "=============== Fin de compression ZIP ==============="
echo
echo 
echo "=============== ENVOIE SUR GITHUB ==============="
cd /script
message="Backup Script : `date +%d-%m-%Y::%H-%M`"
git commit -am "$message"
git pull
git push
echo "=============== Fin envoie SUR GITHUB ==============="
echo
echo
echo "############################ Fin du script de sauvegarde ########################"
echo

echo 
