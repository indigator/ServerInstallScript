#!/bin/bash

VHOSTEN="/etc/nginx/sites-enabled/"

if [[ $1 == "-h" ]] || [[ $1 == "--help" ]]
then
echo 'Usage: NXdissite VHOST'
echo 'Disables Nginxs virtualhost VHOST.'
echo -e '  -h, --help\tDisplays this help'
exit 0
elif [ -f $VHOSTEN$1 ]
then
rm $VHOSTEN$1
echo "Restart Nginx now with \"/etc/init.d/nginx restart\" to enable the change!"
exit 0
else
echo "Virtualhost Config not found."
exit 1
fi