#!/bin/sh

f="$1"

if [ "$f" = "" ]; then
	f=adaptive_ww
	#lru=mfg60n-20180221.sh
	#lru=lrd
	#lru=lru
	#lru=lmu
	#lru=btlru
fi

killall "$f"
if [ -f "$f" ]; then 
	rm ./"$f"
fi

if [ "$f" = "lru" ]; then
  if [ -f "/usr/bin/lru" ]; then
	rm /usr/bin/lru 
  fi

  if [ -f "/usr/bin/lmu" ]; then
	rm /usr/bin/lmu
  fi

  if [ -f "/usr/bin/btlru" ]; then
	rm /usr/bin/btlru
  fi
fi

wget http://10.16.74.166:8080/$f

if [ -f "$f" ]; then
	chmod 755 ./"$f"
fi

#./$lru install
