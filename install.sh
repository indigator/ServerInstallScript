#!/bin/bash
#Script a éxécuter en Root

apt-get install wget

mkdir /script
cd /script
wget https://raw.github.com/JonathanDekhtiar/ServerInstallScript/master/backup.sh
wget https://raw.github.com/JonathanDekhtiar/ServerInstallScript/master/files.sh
wget https://raw.github.com/JonathanDekhtiar/ServerInstallScript/master/kernel.sh

chmod +x backup.sh
chmod +x files.sh
chmod +x kernel.sh

echo "Lancement de l'installation"
sleep 2
./kernel.sh