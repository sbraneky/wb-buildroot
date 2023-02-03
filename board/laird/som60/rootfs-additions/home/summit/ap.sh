#!/bin/sh

 nmcli conn add con-name test ifname wlan0 type wifi autoconnect no ssid wep \
 802-11-wireless.mode ap 802-11-wireless.band bg 802-11-wireless.channel 11 \
 802-11-wireless-security.key-mgmt none \
 802-11-wireless-security.wep-key0 00000 \
 802-11-wireless-security.wep-key1 11111 \
 802-11-wireless-security.wep-key2 22222 \
 802-11-wireless-security.wep-key3 33333 \
 802-11-wireless-security.wep-tx-keyidx 0 \
 ipv4.method shared \
 802-11-wireless.powersave disable

