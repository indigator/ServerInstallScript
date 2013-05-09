#!/bin/bash
#Script a éxécuter en Root

while :
do
    read -p "Quelle est l'adresse IP de votre serveur (ping affiche son IP) : " ip_server
    
    if [[ $ip_server != "" ]]
    then
        break
    fi
    
done

while :
do
    read -p "Quelle est l'adresse web de votre serveur (http://...) : " addr_server
    
    if [[ $addr_server != "" ]]
    then
        break
    fi
    
done

while :
do
    read -p "Quelle est l'adresse IP de votre serveur DNS secondaire (ping affiche son IP) : " ip_dns2
    
    if [[ $ip_dns2 != "" ]]
    then
        break
    fi
    
done

while :
do
    read -p "Quelle est l'adresse web du serveur DNS secondaire (http://...) : " addr_dns2
    
    if [[ $addr_dns2 != "" ]]
    then
        break
    fi
    
done


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
    
    dns='\nzone "'$domain'" {\n
    \t type master;\n
    \t file "/etc/bind/db.'$domain'";\n
    \t allow-transfer {'$ip_dns2';};\n
    \t allow-query{any;};\n
    \t notify yes;\n
    };'
    
    echo -e $dns >> /etc/bind/named.conf.local
        
    cp /etc/bind/db.domain.name /etc/bind/db.$domain
    
    sed -i 's/domain.name/'$domain'/g' /etc/bind/db.$domain 
    sed -i 's/addrdns2/'$addr_dns2'/g' /etc/bind/db.$domain 
    sed -i 's/ipserver/'$ip_server'/g' /etc/bind/db.$domain
    sed -i 's/addrserver/'$addr_server'/g' /etc/bind/db.$domain

    
    read -n1 -p "Voulez-vous déclarer une autre zone DNS (y/N) : " result 
    if [[ $result != "Y" && $result != "y" ]] 
    then
        break
    fi
    echo
  
done