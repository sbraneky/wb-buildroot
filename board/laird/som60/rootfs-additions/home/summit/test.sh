#!/bin/sh
./adaptive_ww &
sleep 1
rm /var/run/adaptive_wwd.pid
./adaptive_ww 

