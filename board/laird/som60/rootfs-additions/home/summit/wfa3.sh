#!/bin/sh

 nmcli conn add con-name wfa3 ifname wlan0 type wifi ssid wfa3 \
 802-11-wireless-security.key-mgmt none \
 802-11-wireless-security.wep-key0 0000000000000 \
 802-11-wireless-security.wep-key1 1234567890123 \
 802-11-wireless-security.wep-key3 3333333333333 \
 802-11-wireless-security.wep-tx-keyidx 1 \
 802-11-wireless.powersave disable
