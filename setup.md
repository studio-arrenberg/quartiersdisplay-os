# Setup Digital Streetsign

## Create OS File
1. Insert Mirco SD Card *SanDisk Extreme Pro* to your Computer
2. [Download](https://www.raspberrypi.com/software/) & Install Raspberry Pi OS Imager
3. Select Raspberry Pi OS Lite (64-bit)
4. Select SD Card
5. On Settings
    1. Set Hostname
    2. Activate SSH => Use Password to Authenticate 
    3. Username & Password
    4. Set Language Preferences 
        1. Timezone => Berlin
        2. keyboard => de
6. Save to SD Card
7. Eject SD Card

## Connect to Pie
1. Insert SD Card
2. Connect Pie via Ethernet to Internet
3. Connect Respberry Pi to Electricity
4. *Wait at least a Minute for the Pie to Boot*
5. Connect via SSH
   1. `ssh arrenberg@display5.local` 
   2. enter password

## Setup Pie
1. Activate VNC Server
   1. Run `sudo raspi-config`
   2. Go to 3. Interface Options
   3. Go to I3 VNC
   4. Would you like the VNC Server to e enabled => YES
   5. Confirm usage if addtional disk space
2. Activate Auto-Login
   1. Go to 1. System Options
   2. Go to S5 Boot / Auto Login
   3. Go to B2 Console Autologin
3. Go to finish
   1. Reboot now
   2. Wait at least a Minute for the pie to boot

## Create Install File
 1. Login to Pie
 2. Run `sudo nano install.sh`
 3. Copy the contents of the Installation File
 4. Save and close editor with `^X`
 5. Make file executable with `sudo chmod +x install.sh`
 6. Run file with `./install.sh`

## Setup Pi for daily business
 1. Remove command line Logo
    1. Run `sudo nano /boot/cmdline.txt`
    2. Add `loglevel=3 quiet logo.nologo` to Line
    3. Save and Close with `^X`
 2. Enable Windowserver
    1. Run `sudo nano .profile`
    2. Add line `sleep 120` &
    3. Line `[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx -- -nocursor &`
    4. To the end of the file
 3. Add Startup Script
    1. Run `sudo nano /etc/rc.local`
    2. Add files 
    3. `bash /home/arrenberg/quartiersdisplay-os/scripts/startup.sh &`
    4. `dmesg --console-off`
 4. Define Startup Programm and settings
    1. Run `sudo nano .xinitrc`
    2. Add content as Below
    3. Save and Close with `^X`
 5. Edit Environment Variable in Repository

## Update & Upgrade
When issues occur update & upgrade Pi as well as Dependencies.

1. `sudo apt-get update`
2. `sudo apt-get upgrade`
3. `./install.sh`
4. `sudo reboot`

## Troubleshooting

### Unable to Login
When unable to login with credientials.
Restart Terminal

### Server does not start
1. Navigate to Repository
2. `cd quartiersdisplay-interface`
3. Run `rm -rf node_modules`
4. Run `npm install --legacy-peer-deps`
5. Or Run `npm install --force`
6. Run `sudo npm run dev`

### VNC Viewer
1. [Download](https://www.realvnc.com/en/connect/download/viewer/macos/) & Install VNC Viewer
2. Get Credentials from PiTunnel
3. E.g. `pitunnel.com:17141` ***without http://***

### Change Screen on SSH
1. Install screen `sudo apt-get install screen`
2. List Screens with `ls /dev/pts/`
3. Change Screen with `sudo screen -x 0`

### Stop Nodejs
1. Run `sudo killall node`
2. RUN `sudo npm run dev`

# Files

### .xinitrc
```sh
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
```


### rc.local
```sh
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

# Print the IP address
_IP=$(hostname -I) || true
if [ "$_IP" ]; then
  printf "My IP address is %s\n" "$_IP"
fi

bash /home/arrenberg/quartiersdisplay-os/scripts/startup.sh &
# Suppress Kernel Messages
dmesg --console-off

exit 0
```

### .profile file
```sh
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

sleep 120
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx -- -nocursor &
```


### Installation File
```sh
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
```