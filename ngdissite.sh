#!/bin/bash

VHOSTEN="/etc/nginx/sites-enabled/"

if [[ $1 == "-h" ]] || [[ $1 == "--help" ]]
then
        echo 'Usage: ngdissite VHOST'
        echo 'Disables Nginxs virtualhost VHOST.'
        echo -e '  -h, --help\tDisplays this help'
        echo
        echo 'Available VHOSTs to disable are:'
        ls $VHOSTEN
        exit 0
elif [ -f $VHOSTEN$1 ]
then
        rm $VHOSTEN$1
        echo "Restart Nginx now with \"sudo service nginx restart\" to enable the change!"
        exit 0
else
        echo "Virtualhost Config not found. Available to disable are:"
        ls $VHOSTEN
        exit 1
fi