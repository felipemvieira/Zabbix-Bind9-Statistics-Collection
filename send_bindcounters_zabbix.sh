#!/bin/bash

OUTPUTFILE="/tmp/bindcounters.txt"
BINDSTATS="/usr/local/bin/bind-stats.py"
ZABBIXSENDER="/usr/sbin/zabbix-sender"
ZABBIXCONFIG="/etc/zabbix/zabbix-agentd.conf"

# Running bind-stats-py
$BINDSTATS printcounters > $OUTPUTFILE 

# Test if the file is created and send it to zabbix server
if [ -f $OUTPUTFILE ]
then
    $ZABBIXSENDER -i $OUTPUTFILE -c $ZABBIXCONFIG
else
    echo "File $OUTPUTFILE not exists"
    exit 1
fi
