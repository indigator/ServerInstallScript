#!/bin/bash
#Script a executer en Root

function replace 
{
    rm $2
    mv $1 $2
}

install="/backup"
cd $install

#On configure les locales
file="/locale/locale"
path="/etc/default/locale"
replace $install$file $path
file="/locale/locale.gen"
path="/etc/locale.gen"
replace $install$file $path
dpkg-reconfigure locales
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

 
#Config SSH => Dossier ssh
file="/ssh/sshd_config"
path="/etc/ssh/sshd_config"
replace $install$file $path
    #On ajoute tous les utilisateurs du système
    /script/user.sh

echo "Configurations SSH a jour"
sleep 2

#Config PHP-FPM => Dossier fpm
file="/fpm/www.conf"
path="/etc/php5/fpm/pool.d/www.conf"
replace $install$file $path
file="/fpm/php-fpm.conf"
path="/etc/php5/fpm/php-fpm.conf"
replace $install$file $path
/etc/init.d/php5-fpm reload
echo "Configurations PHP-FPM a jour"
sleep 2

#Config Nginx => Dossier nginx
file="/nginx/nginx.conf"
path="/etc/nginx/nginx.conf"
replace $install$file $path
file="/nginx/default"
path="/etc/nginx/sites-available/default"
replace $install$file $path
file="/nginx/proxy.conf"
path="/etc/nginx/proxy.conf"
replace $install$file $path
/etc/init.d/nginx restart
echo "Configurations Nginx a jour"
sleep 2

#Config Apache => Dossier apache
file="/apache/apache2.conf"
path="/etc/apache2/apache2.conf"
replace $install$file $path
file="/apache/ports.conf"
path="/etc/apache2/ports.conf"
replace $install$file $path
file="/apache/fastcgi.conf"
path="/etc/apache2/mods-enabled/fastcgi.conf"
replace $install$file $path
a2enmod actions fastcgi alias
/etc/init.d/apache2 restart
echo "Configurations Apache a jour"
sleep 2

#Finish
echo "Fin de la mise a jour"
sleep 1
ls -al -R
sleep 5



