#!/bin/bash
#####Script to monitor the load #####
##### This script executed every min so please add the next hashed line to crontab and edit PATH with your's
# * * * * * bash /YOUR_PATH/MonitoringLoadSystem.sh
####################################################
echo $(uptime | awk '{print $8 $9 $10}' | sed "s/","/ /g" | sed "s/\.//g") > /load.data
IP=$(hostname -I)
##Check if load increasing or not
CAL1=$(awk '{print $1}' "/load.data")
CAL2=$(awk '{print $2}' "/load.data")
CAL3=$(awk '{print $3}' "/load.data")
if [ ${CAL1} -gt ${CAL3} ] 
then
        #echo "Load increasing"
        logger -p local7.alert $(uptime | awk '{print $8 $9 $10}' | sed "s/","/ /g")
        echo " Subject: Server $(IP) load
                Body:
                        Dear, 
                                The system $(hostname) runs with IP $(IP) has a load of 
                                1MIN load: $(uptime | awk '{print $8}' | sed "s/","/ /g")
                                5MIN load: $(uptime | awk '{print $9}' | sed "s/","/ /g")
                                15MIN load: $(uptime | awk '{print $10}' | sed "s/","/ /g")
                        Thank you . 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" >> /tmp/events


else
        echo "Every thing normal"
fi

exit 0
