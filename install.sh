#!/bin/bash
#Script a executer en Root

apt-get install wget ca-certificates

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

chmod +x backup.sh
chmod +x files.sh
chmod +x kernel.sh

echo "Lancement de l'installation"
sleep 2
./kernel.sh