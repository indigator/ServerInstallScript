#!/bin/bash
#Script a éxécuter en Root


while :
do

    while :
    do
        read -p "Veuillez entrer le nom de domaine à configurer (sans les www) : " domain 
        
        if [[ $domain != "" ]]
        then
            break
        fi
        
    done
    
    while :
    do
        read -p "Quelle est l'adresse IP du serveur DNS secondaire (ping affiche son IP) : " dns2
        
        if [[ $dns2 != "" ]]
        then
            break
        fi
        
    done
    
    
    dns='\nzone "'$domain'" {\n
    \t type master;\n
    \t file "/etc/bind/db.'$domain'";\n
    \t allow-transfer {'$dns2';};\n
    \t allow-query{any;};\n
    \t notify yes;\n
    };'
    
    echo -e $dns >> /etc/bind/named.conf.local
        
    cp /etc/bind/db.domain.name /etc/bind/db.$domain
    
    read -n1 -p "Voulez-vous déclarer une autre zone DNS (y/N) : " result 
    if [[ $result != "Y" && $result != "y" ]] 
    then
        break
    fi
    echo
  
done