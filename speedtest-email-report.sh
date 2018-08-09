#!/usr/bin/env bash

DATE=$(date '+%Y-%m-%d %H:%M:%S')
RECIEPIENT=$(</etc/reportUser)
SPEEDTEST_OUT=$(speedtest)
$(echo "${SPEEDTEST_OUT}" | mail -s "Speedtest Results at $DATE" $RECIEPIENT)
