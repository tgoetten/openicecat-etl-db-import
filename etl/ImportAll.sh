#!/bin/bash

# create a backup of serialised-data
#tar -zcvpf serialised-data/$(date +%Y-%m-%d)-serialised-data-backup.tar.gz serialised-data/*.cube

# Delete cube and xml files
find . -type f -name "*.cube" -exec rm {} \; 
find . -type f -name "*.xml" -exec rm {} \; 

sh /opt/data-integration/kitchen.sh -file=ImportAll.kjb ImportAll.kjb -level=Debug -logfile=ImportAll.txt -level=Basic
