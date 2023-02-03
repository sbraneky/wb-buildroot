#!/bin/sh

nmcli conn add con-name ccopen ifname wlan0 type wifi ssid  ccopen
nmcli conn modify id 'ccopen' 802-11-wireless.powersave enable

