#!/bin/bash 
echo
echo "################### Ajoutons de Nouveaux Utilisateurs #####################"
echo
echo "Nous allons ajouter l'utilisateur admin (non root)" 
adduser --shell /usr/bin/lshell admin
echo
sed -i '/^AllowUsers/ s/$/ '$user'/' /etc/ssh/sshd_config
echo "L'utilisateur "$user" peut maintenant se connecter en SSH avec un shell Limité"
echo
echo

while :
do
    read -p "Nous allons ajouter un utilisateur, son nom ( - 1 to quit ) : " user 
    
    if [ $user -eq -1 ]
	then
		break
	fi
	
	adduser --shell /usr/bin/lshell $user
	
	read -n1 -p "Voulez-vous lui autoriser un accès SSH (y/N) :" result 
    if [[ $result == "Y" || $result == "y" ]]; then
        echo
        sed -i '/^AllowUsers/ s/$/ '$user'/' /etc/ssh/sshd_config
        echo "L'utilisateur "$user" peut maintenant se connecter en SSH avec un shell Limité"
	fi
	sleep 1
	echo 
done

service ssh restart
echo
echo "################### Fin de l'ajout des nouveaux utilisateurs #####################"
echo
sleep 2