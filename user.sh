#!/bin/bash 

while read -p "Nous allons ajouter un utilisateur, son nom ( - 1 to quit ) : " user do    
    if [ $user -eq -1 ]
	then
		break
	fi
	adduser --shell /usr/bin/lshell $user
	echo "N'oublis pas de modifier les AllowUsers du fichiers : /etc/ssh/sshd_config"
	sleep 2
	echo 
done

#usermod --shell /usr/bin/lshell nomUser