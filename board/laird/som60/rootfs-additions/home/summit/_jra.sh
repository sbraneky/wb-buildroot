#!/bin/sh

nmcli conn add con-name jra-1250 ifname wlan0 type wifi ssid JRA-1250-PSK
nmcli conn modify id 'jra-1250' 802-11-wireless-security.key-mgmt wpa-psk
nmcli conn modify id 'jra-1250' 802-11-wireless-security.psk wpaversion2
nmcli conn modify id 'jra-1250' 802-11-wireless.powersave disable

