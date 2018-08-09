#!/usr/bin/env bash

DATE=$(date '+%Y-%m-%d %H:%M:%S')
RECIEPIENT=$(</etc/reportUser)
HOSTS=(google.ca 8.8.8.8 206.248.154.22 192.168.0.1)
REPORT_OUT="/tmp/ping-email-${DATE}.txt"
for HOST in ${HOSTS[*]}
do
    $(ping -4 -c 25 $HOST &>> "$REPORT_OUT")
    $(printf "\n\n" &>> "$REPORT_OUT")
done
$(mail -s "Ping Results at $DATE" $RECIEPIENT < "$REPORT_OUT")
$(rm "$REPORT_OUT")
