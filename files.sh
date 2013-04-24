#!/bin/bash
#Script a executer en Root

function replace 
{
    
    if [ -f $2 ] #Si le fichier $2 existe
    then
        rm $2
    fi
    
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
echo "=============== Locales mises a jour ==============="
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
echo "=============== Hostnames a jours ==============="
sleep 2

#shell => dossier shell
file="/shell/.bashrc"
path="/root/.bashrc"
replace $install$file $path
echo "=============== Configurations Shell en place ==============="
sleep 2

# Lshell => dossier lshell
file="/lshell/lshell.conf"
path="/etc/lshell.conf"
replace $install$file $path
echo "=============== Configurations LShell en place ==============="
sleep 2

 
#Config SSH => Dossier ssh
file="/ssh/sshd_config"
path="/etc/ssh/sshd_config"
replace $install$file $path
    #On ajoute tous les utilisateurs du système
    /script/user.sh

echo "=============== Configurations SSH a jour ==============="
sleep 2

#Config PHP-FPM => Dossier fpm
file="/fpm/www.conf"
path="/etc/php5/fpm/pool.d/www.conf"
#replace $install$file $path
file="/fpm/php-fpm.conf"
path="/etc/php5/fpm/php-fpm.conf"
#replace $install$file $path
/etc/init.d/php5-fpm reload
echo "=============== Configurations PHP-FPM a jour ==============="
sleep 2

#Config Nginx => Dossier nginx
file="/nginx/nginx.conf"
path="/etc/nginx/nginx.conf"
#replace $install$file $path
file="/nginx/default"
path="/etc/nginx/sites-available/default"
#replace $install$file $path
file="/nginx/proxy.conf"
path="/etc/nginx/proxy.conf"
#replace $install$file $path
/etc/init.d/nginx restart
echo "=============== Configurations Nginx a jour ==============="
sleep 2

#Config Apache => Dossier apache
#file="/apache/apache2.conf"
#path="/etc/apache2/apache2.conf"
#replace $install$file $path
#file="/apache/ports.conf"
#path="/etc/apache2/ports.conf"
#replace $install$file $path
#file="/apache/fastcgi.conf"
#path="/etc/apache2/mods-available/fastcgi.conf"
#replace $install$file $path
#file="/apache/php.ini"
#path="/etc/php5/apache2/php.ini"
#replace $install$file $path
#a2enmod actions alias fastcgi
#/etc/init.d/apache2 restart
#echo "=============== Configurations Apache a jour ==============="
#sleep 2

#Config Vim => Dossier vim
file="/vim/vimrc.local"
path="/etc/vim/vimrc.local"
replace $install$file $path
file="/vim/molokai.vim"
path="/usr/share/vim/vimcurrent/colors/molokai.vim"
replace $install$file $path
echo "=============== Configurations VIM a jour ==============="
sleep 2

#Configuration de GIT
git config --global user.name "JonathanDekhtiar - Diablo.Server"
git config --global user.email contact@jonathandekhtiar.eu
cd ~/.ssh
ssh-keygen -t rsa -C "marco.flint31@gmail.com"

echo "############ SSH-Public KEY // COPY TO CLIPBOARD ###########"
echo
cat  ~/.ssh/id_rsa.pub
echo
echo "############ SSH-Public KEY // COPY TO CLIPBOARD ###########"

cd $install
sleep 6

#Configuration de OwnCloud
echo "On ajoute l'utilisateur OwnCloud :"
adduser owncloud
wget http://download.owncloud.org/community/owncloud-5.0.0.tar.bz2
tar -xjf owncloud-5.0.0.tar.bz2
rm owncloud-5.0.0.tar.bz2
mv owncloud www
mv www /home/owncloud/
chmod -R owncloud:owncloud /home/owncloud/
echo "=============== Configurations OWNCLOUD a jour ==============="
sleep 2

#Confiuration ProFTPd => Dossier proftpd
file="/proftpd/proftpd.conf"
path="/etc/proftpd/proftpd.conf"
replace $install$file $path
file="/proftpd/modules.conf"
path="/etc/proftpd/modules.conf"
replace $install$file $path
/etc/init.d/proftpd restart
echo "=============== Configurations ProFTPd a jour ==============="

#On sauvegarde Mysql
file="/mysql/my.cnf"
path="/etc/mysql/my.cnf"
replace $install$file $path
/etc/init.d/mysql reload
echo "Nous allons configurer Mysql, entrer le MdP Root, puis répondre 'No' a la première question puis 'Yes' a toutes les autres"
sleep 4
mysql_secure_installation
echo
echo "=============== Configurations Mysql a jour ==============="

#Finish
echo
echo "####################################  Fin du script d'install ####################################"
echo
sleep 2
ls -al -R
sleep 5



