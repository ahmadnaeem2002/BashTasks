#!/bin/bash
#####Script to monitor the load #####
##### This script executed every min so please add the next hashed line to crontab and edit PATH with your's
# */1 * * * * /PATH/MonitoringLoadSystem.sh
####################################################
echo $(uptime | awk '{print $8 $9 $10}' | sed "s/","/ /g" | sed "s/\.//g") > /load.data

##Check if load increasing or not
CAL1=$(awk '{print $1}' "/load.data")
CAL2=$(awk '{print $2}' "/load.data")
CAL3=$(awk '{print $3}' "/load.data")
if [ ${CAL1} -gt ${CAL3} ]
then
        echo "Load increasing"
        echo $(uptime | awk '{print $8 $9 $10}' | sed "s/","/ /g" | sed "s/\.//g") >> /var/log/systemLoad && date >> /var/log/systemLoad
        echo " Subject: Server $(hostname -I) load
                Body:
                        Dear, 
                                The system $(hostname) runs with IP $(hostname -I) has a load of 
                                1MIN load: ${CAL1}
                                5MIN load: ${CAL2}
                                15MIN load: ${CAL3}
                        Thank you . 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" >> /tmp/events


else
        echo "Every thing normal"
fi

exit 0
