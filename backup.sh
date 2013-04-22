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

#On sauvegarde les Confs LShell => Limited Shell
mkdir lshell
file="/lshell/lshell.conf"
path="/etc/lshell.conf"
cp $path $backup$file 
echo "Configurations Lshell sauvegardées"

#On sauvegarde les conf SSH
mkdir ssh
file="/ssh/sshd_config"
path="/etc/ssh/sshd_config"
cp $path $backup$file
sed -E 's/^AllowUsers.*/AllowUsers/'  /ssh/sshd_config
#sed 's/^AllowUsers.*/AllowUsers/' /ssh/sshd_config
service ssh restart 
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
file="/nginx/proxy.conf"
path="/etc/nginx/proxy.conf"
cp $path $backup$file
 echo "Configurations NGINX sauvegardées"

#On sauvegarde les confs PHP-FPM
mkdir fpm
file="/fpm/www.conf"
path="/etc/php5/fpm/pool.d/www.conf"
cp $path $backup$file
file="/fpm/php-fpm.conf"
path="/etc/php5/fpm/php-fpm.conf"
cp $path $backup$file
echo "Configurations PHP-FPM sauvegardées"

#On sauvegarde les confs Apache2
mkdir apache
file="/apache/apache2.conf"
path="/etc/apache2/apache2.conf"
cp $path $backup$file
file="/apache/ports.conf"
path="/etc/apache2/ports.conf"
cp $path $backup$file
file="/apache/fastcgi.conf"
path="/etc/apache2/mods-enabled/fastcgi.conf"
cp $path $backup$file
echo "Configurations Apache2 sauvegardées"

#On sauvegarde les Vhost
mkdir vhosts
    #Apache
    file="/vhosts/apache.zip"
    target="/etc/apache2/sites-enabled/"
    zip -r $backup$file $target
    
    #Nginx
    file="/vhosts/nginx.zip"
    target="/etc/nginx/sites-enabled/"
    zip -r $backup$file $target
echo "Configurations Vhosts Sauvegardées"

#Fin du Script
mkdir zip
file="/backup.zip"
target="/script/Files"
rm $target$file
zip -r $target$file $backup
echo "Fin de compression ZIP"
echo "******* Fin du script de sauvegarde ********"
