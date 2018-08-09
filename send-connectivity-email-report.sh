#!/usr/bin/env bash

RECIEPIENT=$(</etc/reportUser)
EXTERNAL_TEST="https://www.google.ca/"
LOGFILE="/var/log/connecifity.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')
EMAIL_FILE="/var/log/connectifity.email"

EXT_TEST=$(curl -o /dev/null --connect-timeout 30 -s -w "%{http_code}\n" "$EXTERNAL_TEST")
if [[ $EXT_TEST -eq 200 ]]
  then
    $(mv "$LOGFILE" "$EMAIL_FILE")	
    $(mail -s "Connectivity Log at $DATE" $RECIEPIENT < "$EMAIL_FILE")    
    $(rm "$EMAIL_FILE")
fi
