#!/bin/bash
# Wait for Internet Connection
sleep 30
echo "Start Git Update"
git -C /home/arrenberg/quartiersdisplay-interface fetch
git -C /home/arrenberg/quartiersdisplay-interface stash
git -C /home/arrenberg/quartiersdisplay-interface pull
echo "Git Update erledigt"
echo "Update Next Server"
npm --prefix /home/arrenberg/quartiersdisplay-interface/ install 
npm --prefix /home/arrenberg/quartiersdisplay-interface/ run build
npm --prefix /home/arrenberg/quartiersdisplay-interface/ run start &

echo "Next environment running"


exit




