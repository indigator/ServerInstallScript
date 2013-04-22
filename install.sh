#!/bin/bash
#Script a executer en Root

########### À éxéuter avant de pouvoir lancer le script ###############
#
#   apt-get install wget ca-certificates
#   cd /
#   wget https://github.com/JonathanDekhtiar/ServerInstallScript/raw/master/install.sh
#   chmod +x ./install.sh
#   ./install.sh
#
########### À éxéuter avant de pouvoir lancer le script ###############

echo "Changeons le Mot de Passe Administrateur :"

passwd

if [ -d /script ]
then
    rm -R /script
fi

if [ -f /backup.zip ]
then
    rm /backup.zip
fi

if [ -d /backup ]
then
    rm -R /backup
fi

mkdir /script
cd /script

wget https://github.com/JonathanDekhtiar/ServerInstallScript/raw/master/kernel.sh
wget https://github.com/JonathanDekhtiar/ServerInstallScript/raw/master/files.sh
wget https://github.com/JonathanDekhtiar/ServerInstallScript/raw/master/backup.sh
wget https://github.com/JonathanDekhtiar/ServerInstallScript/raw/master/files.sh

chmod +x backup.sh
chmod +x files.sh
chmod +x kernel.sh
chmod +x files.sh

echo "Lancement de l'installation"
sleep 2
./kernel.sh
./files.sh

# On reboot le server
echo "On reboot"
sleep 1
reboot