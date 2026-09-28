#!/bin/bash
# Amphetamine prevents real system sleep, so sleepwatcher never fires; restart the Logi daemon on display wake instead.
LOG=/tmp/displaywake-watcher.log
echo "$(date '+%F %T') watcher started" >> "$LOG"

/usr/bin/log stream --style compact --predicate 'process == "WindowServer" and eventMessage contains "Did Wake"' | while read -r _; do
  echo "$(date '+%F %T') display wake detected" >> "$LOG"
  /usr/bin/pkill -i LogiMgrDaemon
done
