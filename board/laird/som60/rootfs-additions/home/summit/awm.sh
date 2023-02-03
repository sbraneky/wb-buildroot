#!/bin/sh
awm=adaptive_ww
db=regpwr.db

killall $awm
rm ./$db

rm ./$awm
wget http://10.16.74.166:8080/$awm
chmod 755 ./$awm

wget http://10.16.74.166:8080/$db
cp ./$db /lib/firmware
