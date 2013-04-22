#!/bin/bash 

while :
do
    read -p "Nous allons ajouter un utilisateur, son nom ( - 1 to quit ) : " user 
    
    if [ $user -eq -1 ]
	then
		break
	fi
	
	adduser --shell /usr/bin/lshell $user
	sed -i '/^AllowUsers/ s/$/ '$user'/' /etc/ssh/sshd_config
	echo "L'utilisateur peut maintenant se connecter en SSH avec un shell Limité"
	#echo "N'oublis pas de modifier les AllowUsers du fichiers : /etc/ssh/sshd_config"
	sleep 2
	echo 
done

#usermod --shell /usr/bin/lshell nomUser