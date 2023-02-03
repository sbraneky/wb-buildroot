#!/bin/sh

x=1

while [ "$x" -eq 1 ]
  do
	echo "scanning"
	iw dev wlan0 scan flush > /dev/null
	y=$(( ( RANDOM % 10 ) +1 ))
	echo "sleeping $y"
	sleep $y
	echo "awake"
  done

