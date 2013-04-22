#!/bin/bash
#Script a éxécuter en Root

function replace 
{
    rm $2
    mv $1 $2
}

#On met le système a jour
install="/backup"
cd $install
 
#Config SSH => Dossier ssh
adduser admin
file="/ssh/sshd_config"
path="/etc/ssh/sshd_config"
replace $install$file $path
/etc/init.d/ssh restart

#Config Nginx => Dossier nginx
file="/nginx/nginx.conf"
path="/etc/nginx/nginx.conf"
replace $install$file $path
file="/nginx/default"
path="/etc/nginx/sites-available/default"
replace $install$file $path
/etc/init.d/nginx restart
/etc/init.d/php5-fpm reload

#Finish
ls -al -R


