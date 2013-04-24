#!/bin/bash


VHOSTEN="/etc/nginx/sites-enabled/"
VHOSTAV="/etc/nginx/sites-available/"

if [[ $1 == "-h" ]] || [[ $1 == "--help" ]]
then
        echo 'Usage: ngensite VHOST [-f]'
        echo 'Enables Nginxs virtualhost VHOST [option].'
        echo -e '  -f\t\tForce enabling VHOST'
        echo -e '    \t\tAlways sepcify -f after VHOST!'
        echo -e '  -h, --help\tDisplays this help'
        echo
        echo 'Available VHOSTs to enable are:'
        ls $VHOSTAV
        exit 0
elif [ -f $VHOSTAV$1 ] && ( [ ! -f $VHOSTEN$1 ] || [[ $2 == "-f" ]] )
then
        
        [[ $2 == "-f" ]] && rm $VHOSTEN$1 &> /dev/null #On force l'execution en redirigeant les erreurs dans le vide
        
        ln -s $VHOSTAV$1 $VHOSTEN$1
        if [ -f $VHOSTEN$1 ]
        then
                echo "Restart Nginx now with \"sudo service nginx restart\" to enable the change!"
                exit 0
        else
                echo "Error in the execution."
                exit 1
        fi
        
elif [ -f $VHOSTEN$1 ]
then
        echo "Virtualhost already enabled."
        exit 0
else
        echo "Virtualhost config not found. Available to enable are:"
        ls $VHOSTAV
        exit 1
fi