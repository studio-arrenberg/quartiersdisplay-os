#!/bin/bash
#//Install git, openbox, xserver, chromium, vnc, npm, node js,
echo "Install dependencies"
sudo apt-get install chromium-browser
sudo apt-get install openbox
sudo apt-get install unclutter
sudo apt-get install git
sudo apt-get install -y nodejs
sudo apt-get install -y npm

echo "Setup Git Repository"
git clone https://github.com/studio-arrenberg/quartiersdisplay-interface.git

echo "Setup Next environment"
npm install
npm next build


echo "Modify files"
