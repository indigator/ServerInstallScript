#!/bin/bash 

while :
do
    read -p "Nous allons ajouter un utilisateur, son nom ( - 1 to quit ) : " user 
        
    if [ $user -eq -1 ]
    then
        break
    fi
    
    adduser --shell /usr/bin/lshell $user
  
    read -n1 -p "Voulez-vous lui creer un VHOST (y/N) :" result 
    if [[ $result == "Y" || $result == "y" ]]; then
        echo
        mkdir /home/$user/www
        chown -R $user:$user /home/$user/
        read -p "Quelle est l'adresse ou les adresses (séparés par des espaces) du site http://" server
        /script/createvhost.sh server /home/$user/www
        echo "L'utilisateur "$user" peut maintenant créer un siteweb dans son répertoire www/"
    fi
    
    read -n1 -p "Voulez-vous lui autoriser un accès SSH (y/N) :" result 
    if [[ $result == "Y" || $result == "y" ]]; then
        echo
        sed -i '/^AllowUsers/ s/$/ '$user'/' /etc/ssh/sshd_config
        echo "L'utilisateur "$user" peut maintenant se connecter en SSH avec un shell Limité"
    fi
    
    sleep 2
    echo 
    
done
