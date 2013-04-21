#!/bin/bash
#Script à éxécuter en Root

function replace 
{
    rm $2
    mv $1 $2
}

#On met le système à jour
install=`echo /install`
cd $install
 
#Config SSH => Dossier ssh
adduser admin
file="/ssh/sshd_config"
path="/etc/ssh/sshd_config"
replace $install$file $path
/etc/init.d/ssh restart

