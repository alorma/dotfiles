#!/bin/bash
# Run by sleepwatcher (~/.wakeup) after a real system wake.
echo "$(date '+%F %T') system wake" >> /tmp/wakeup.log
sleep 3
/usr/bin/pkill -i LogiMgrDaemon
