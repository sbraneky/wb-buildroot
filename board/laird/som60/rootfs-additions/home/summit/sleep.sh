#!/bin/sh
SL=M

case $1 in
  M) SL=M;;
  m) SL=M;;
  F) SL=F;;
  f) SL=F;;
esac

echo "sleep is $SL"

if [ "$SL" = "M" ]
then
echo "mem"
echo "mem" > /sys/power/state
else
if [ "$SL" = "F" ]
then
echo "freeze"
echo "freeze" > /sys/power/state
fi
fi
