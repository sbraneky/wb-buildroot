#!/bin/sh

 nmcli conn add con-name test ifname wlan0 type wifi autoconnect no ssid wep \
 802-11-wireless.mode ap 802-11-wireless.band bg 802-11-wireless.channel 11 \
 802-11-wireless-security.key-mgmt wpa-psk \
 802-11-wireless-security.psk arkansas \
 ipv4.method shared \
 802-11-wireless.powersave disable

