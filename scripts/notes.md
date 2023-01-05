
### Activate Cron Service on Raspberry
    /etc/init.d/cron start

### Remove Command Line Logo on startup
Add the following in `cmdline.txt` file and change 

    loglevel=3 quiet logo.nologo

### Change Console Output to 3
    sudo nano /boot/cmdline.txt
 
add `logo.nologo` at the end

install rfkill  

### Add line to the .profile in home folder to startup the window server
    sudo nano .profile

File Content

    sleep 120
    [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx -- -nocursor &


### Manually Change the Graphic Memory to 3072 MB
    sudo raspi-config

### Disable Wifi in config.txt
    dtoverlay=disable-wifi

### Install Pitunnel and setup SSH and VNC Port
    curl -s pitunnel.com/get/bP8fr3z2i | sudo bash

### add Startup Script to rc.local file
Change Startup settings

    sudo nano /etc/rc.local

Add the following to the file:

    bash /home/arrenberg/quartiersdisplay-os/scripts/startup.sh &
    #Suppress Kernel Messages
    dmesg --console-off


## Create .xinitrc File in Home Directory
    sudo nano .xinbit

This is the file content

    #!/usr/bin/env sh
    xset -dpms
    xset s off
    xset s noblank

    unclutter &
    chromium-browser http://localhost:3000 \
    --window-size=1920,1080 \
    --window-position=0,0 \
    --start-fullscreen \
    --kiosk \
    --incognito \
    --fast-start

## Create .env and setup endpoint
    NEXT_PUBLIC_UNIQUE_IDENTIFIER=
    NEXT_PUBLIC_MAC_ADDRESS=

    # NEXT_PUBLIC_QUARTIERSPLATTFORM_API_ENDPOINT="https://arrenberg.app/wp-json"
    # NEXT_PUBLIC_QUARTIERSPLATTFORM_API_ENDPOINT="http://localhost/quartiersplattform/quartiersdisplay-api/"
    NEXT_PUBLIC_QUARTIERSPLATTFORM_API_ENDPOINT="https://arrenberg.app/quartiersdisplay-api/"

    NEXT_PUBLIC_LOCATION_STRING="Simons"
    NEXT_PUBLIC_LOCATION_LATITUDE=
    NEXT_PUBLIC_LOCATION_LONGITUDE=
    NEXT_PUBLIC_ORIENTATION=

