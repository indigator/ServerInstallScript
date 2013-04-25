#!/bin/bash


path="/etc/nginx/sites-available/"
from="default"
server=$1 # $1 : l'adresse du site web
root=$2 # $2 : Le chemin des fichiers
to=$3 # $3 : le nom du fichier vhost

if [[ $1 == "-h" ]] || [[ $1 == "--help" ]]
then
        echo 'Usage: createvhost.sh SERVER ROOT NAME'
        echo '[option]:'
        echo '  -h, --help => Displays this help'
        echo
        exit 0
elif [ -d $2 ] && [ -f $path$from ]
then
        cp $path$from $path$to  
        sed -i '/server_name/ s/$/ '$server';/' $path$to 
        sed -i '/root/ s/$/ '$root';/' $path$to     
        
else
        echo "default file is missing or root directory is missing"
        echo "Sites available : "
        ls $path
        exit 1
fi
