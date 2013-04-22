#!/bin/bash 

echo
echo "################### Ajoutons de Nouveaux Utilisateurs #####################"
echo

addgroup sftpusers #On crée le groupe des utilisateurs du sFTP

echo "Nous allons ajouter l'utilisateur admin (non root) : " 

adduser --shell /usr/bin/lshell admin
mkdir /home/admin/www
chown -R root:root /home/admin/
chmod 755 /home/admin/
chown admin:admin /home/admin/www
usermod -G admin,sftpusers -a admin

echo
sed -i '/^AllowUsers/ s/$/ admin/' /etc/ssh/sshd_config
echo "L'utilisateur admin peut maintenant se connecter en SSH avec un shell Limité"
echo
echo

#On appelle le script de création d'utilisateurs
/script/adduser.sh


service ssh restart
echo
echo "################### Fin de l'ajout des nouveaux utilisateurs #####################"
echo
sleep 2