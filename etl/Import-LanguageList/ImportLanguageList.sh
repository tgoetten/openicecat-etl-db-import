#!/bin/bash

# create a backup of serialised-data
tar -zcvpf serialised-data/$(date +%Y-%m-%d)-serialised-data-backup.tar.gz serialised-data/*.cube

# Delete backup files than 30 days #
find serialised-data/*.tar.gz -mtime +30 -exec rm {} \;

#cd /opt/data-integration >/dev/null
sh /opt/data-integration/kitchen.sh -file=ImportLanguageList.kjb ImportLanguageList.kjb -level=Debug -logfile=ImportLanguageList.txt -level=Basic
