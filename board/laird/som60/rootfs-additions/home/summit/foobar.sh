#!/bin/sh

nmcli conn add con-name foobar ifname wlan0 type wifi ssid foobar 
nmcli conn modify id 'foobar' 802-11-wireless.powersave disable 

