#!/bin/bash 

while :
do
    read -p "Nous allons ajouter un utilisateur, son nom ( - 1 to quit ) : " user 
        
    if [ $user -eq -1 ]
    then
        break
    fi
    
    adduser --shell /usr/bin/lshell $user
    
    mkdir /home/$user/www
    #chown -R root:root /home/$user/
    #chmod 755 /home/$user/
    #chown $user:$user /home/$user/www
    #usermod -G $user,sftpusers -a $user
    
    
    read -n1 -p "Voulez-vous lui autoriser un accès SSH (y/N) :" result 
    if [[ $result == "Y" || $result == "y" ]]; then
        echo
        sed -i '/^AllowUsers/ s/$/ '$user'/' /etc/ssh/sshd_config
        echo "L'utilisateur "$user" peut maintenant se connecter en SSH avec un shell Limité"
    fi
    
    sleep 2
    echo 
    
done

sed -i '/^AllowUsers/ s/$/ comet/' /etc/ssh/sshd_config
