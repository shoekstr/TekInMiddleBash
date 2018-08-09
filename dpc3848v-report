#!/usr/bin/env bash

LOG_PAGE_URL="http://192.168.0.1/Docsis_log.php"
RF_PAGE_URL="http://192.168.0.1/Docsis_system.php"
DATE=$(date '+%Y-%m-%d %H:%M:%S')
REPORT_FILE="/var/log/modem-report-${DATE}.txt"

$(printf "\n\tModem Diagnostic Report for ${DATE}\n" &>> "${REPORT_FILE}")
$(curl "${RF_PAGE_URL}" > /tmp/rf_page.html)
STATUS=$(cat /tmp/rf_page.html | grep -n "var cableStatus" | grep -o -P '(?<=\").*(?=\")')
$(printf "\nModem Status: %s\n" % "${STATUS}" &>> "${REPORT_FILE}")
$(printf "\nCable Modem Signals\n\tDS and SNR:\n" &>> "${REPORT_FILE}")
#DS Signals 
$(cat /tmp/rf_page.html |sed -n '/<table class="std" summary="this table shows downstream channel information">/,/<\/table>/p' | lynx -stdin -dump &>> "${REPORT_FILE}")
$(printf "\n\tUS:\n" &>> "${REPORT_FILE}")
# US Signals
$(cat /tmp/rf_page.html |sed -n '/<table class="std" summary="this table shows upstream channel information">/,/<\/table>/p' | lynx -stdin -dump &>> "${REPORT_FILE}")
#$(printf "\n\tSNR:\n" &>> "${REPORT_FILE}")
# SNR Signals
$(printf "\nModem Logs:\n" &>> "${REPORT_FILE}")
$(curl "$LOG_PAGE_URL" | hxnormalize -x | hxselect -i "table.dataTable" | lynx -stdin -dump >>  "${REPORT_FILE}")
$(rm /tmp/rf_page.html)
