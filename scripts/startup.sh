#!/bin/bash
sleep 30
echo "Starting nodejs Server"
git fetch
git stash
git pull
echo "Git Update erledigt"
npm install
npm run dev

echo "Next environment running"

echo "Start Window Server"
startx -- -nocursor
