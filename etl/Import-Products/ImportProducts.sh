#!/bin/bash

sh /opt/data-integration/kitchen.sh -file=ImportProducts.kjb ImportProducts.kjb -level=Debug -logfile=ImportProducts.txt -level=Basic -param:extract=false -param:filename=files.index.xml -param:langid=1 -param:url=http://data.icecat.biz/export/freexml.int/EN/files.index.xml
