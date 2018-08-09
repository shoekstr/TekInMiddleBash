#!/usr/bin/env bash

INTERNAL_TEST="http://192.168.0.1/Docsis_system.php"
INTERNAL_NAME="The Modem"
EXTERNAL_TEST="https://www.google.ca/"
EXTERNAL_NAME="The Google"
LOGFILE="/var/log/connecifity.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')
CONNECTED=$(cat /sys/class/net/eth0/carrier)
OUTLINE=""

if [[ $CONNECTED -eq 1 ]]
  then
    IP=$(ip -f inet -o addr show eth0|cut -d\  -f 7 | cut -d/ -f 1)
    EXT_TEST=$(curl -o /dev/null --connect-timeout 30 -s -w "%{http_code}\n" "$EXTERNAL_TEST")
    EXT_TEXT="CAN NOT"
    if [[ $EXT_TEST -eq 200 ]]
      then
        EXT_TEXT="CAN"
    fi
    INT_TEST=$(curl -o /dev/null --connect-timeout 30 -s -w "%{http_code}\n" "$INTERNAL_TEST")
    INT_TEXT="CAN NOT"
    if [[ $INT_TEST -eq 200 ]]
      then
        EXT_TEXT="CAN"
    fi
    OUTLINE="${DATE}: Ethernet is CONNECTED with an ip address of ${IP}. I ${INT_TEXT} communicate with ${INTERNAL_NAME} and I ${EXT_TEXT} communicate with ${EXTERNAL_NAME}" 
fi
if [[ $CONNECTED -eq 0 ]]
  then
    OUTLINE="${DATE}: Ethernet is DISCONNECTED"
fi
$(echo "$OUTLINE" >> "$LOGFILE")
