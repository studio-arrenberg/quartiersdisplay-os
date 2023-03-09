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
sudo apt-get update
sudo apt-get upgrade


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
