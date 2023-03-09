
## Setup Raspberry Pi for the digital street sign
### 1. Go to Settings with `sudo raspi-config`
   1. Activate VNC Server
   2. Setup Autologin to console
### 2. Create Install.sh and run it
    sudo nano install.sh

Add the following code to the newly created file

    #!/bin/bash
    #//Install git, openbox, xserver, chromium, vnc, npm, node js,
    echo "Activate Cron Server"
    sudo /etc/init.d/cron start

    echo "Install dependencies"
    sudo apt-get install -y chromium-browser
    sudo apt-get install -y xserver-xorg
    sudo apt-get install -y realvnc-vnc-server
    sudo apt-get install -y xinit
    sudo apt-get install -y openbox
    sudo apt-get install -y unclutter
    sudo apt-get install -y git
    sudo apt-get install -y nodejs
    sudo apt-get install -y npm
    sudo apt-get install -y rfkill
    sudo apt-get install -y htop

    echo "Setup Git Repository"
    git clone https://github.com/studio-arrenberg/quartiersdisplay-interface.git
    git clone https://github.com/studio-arrenberg/quartiersdisplay-os.git

    echo "Setup Pitunnel"
    curl -s pitunnel.com/get/bP8fr3z2i | sudo bash

    #echo "Setup Next environment"
    #npm install
    #npm run build
    #npm run start

    #Future
    #echo "Modify files"

    exit 

Make the file executable
    
    sudo chmod +x install.sh

Run the newly created file
    
    ./install.sh


### 3. Remove command line logo and logs on startup
Add the following in `cmdline.txt` file and change 
    
    sudo nano /boot/cmdline.txt

And this line to the file and change console output to 3

    loglevel=3 quiet logo.nologo

### 4. Add line to the .profile in home folder to startup the window server
    sudo nano .profile

File Content

    sleep 120
    [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx -- -nocursor &


### 5. Manually Change the Graphic Memory to 3072 MB
    sudo raspi-config

### 6. Disable Wifi in config.txt
    dtoverlay=disable-wifi
### 7. Add Startup Script to rc.local file
Change Startup settings with `sudo nano /etc/rc.local`
    
Add the following to the file:

    bash /home/arrenberg/quartiersdisplay-os/scripts/startup.sh &
    #Suppress Kernel Messages
    dmesg --console-off

### 8. Create .xinitrc File in Home Directory
    sudo nano .xinitrc

This is the file content

    #!/usr/bin/env sh
    xset -dpms
    xset s off
    xset s noblank

    unclutter &
    /usr/bin/chromium-browser http://localhost:3000 \
    --window-size=1920,1080 \
    --window-position=0,0 \
    --start-fullscreen \
    --kiosk \
    --incognito \
    --fast-start \
    --noerrdialogs \
    --disable-infobars


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

