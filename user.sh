#!/bin/bash 

while :
do
    read -p "Nous allons ajouter un utilisateur, son nom ( - 1 to quit ) : " user 
    
    if [ $user -eq -1 ]
	then
		break
	fi
	
	adduser --shell /usr/bin/lshell $user
	
	read -p "Voulez-vous lui autoriser un accès SSH (y/N) :" result 
    if  [ "$result" = "y" || "$result" = "Y"]
	then
        sed -i '/^AllowUsers/ s/$/ '$user'/' /etc/ssh/sshd_config
        echo "L'utilisateur "$user" peut maintenant se connecter en SSH avec un shell Limité"
	fi
	sleep 1
	echo 
done

service ssh restart

sleep 2