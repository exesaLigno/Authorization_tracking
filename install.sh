#!/bin/bash

storage_length=20
camera="/dev/video0"
resolution="1024x768"
path="$HOME/.logins"

if ! [[ -f `which fswebcam` ]]; then
    echo "Installing fswebcam"
    sudo apt-get install fswebcam
fi

if ! [[ -d $path ]]; then 
    echo "Creating $path"
    mkdir $path
fi

if ! [[ -f /usr/bin/logins ]]; then
    sudo cat logins | tee /usr/bin/logins
    sudo chmod +x /usr/bin/logins
    if [[ -f /etc/gdm3/PostLogin/Default ]]; then
        sudo echo "#!/bin/sh" >> /etc/gdm3/PostLogin/Default
        sudo echo "logins -c" >> /etc/gdm3/PostLogin/Default
    else
        sudo echo "logins -c" >> /etc/gdm3/PostLogin/Default
    fi
    sudo chmod +x /etc/gdm3/PostLogin/Default
else
    echo "conflict with existing \"logins\" programm at /usr/bin/" > error_log.txt
fi
