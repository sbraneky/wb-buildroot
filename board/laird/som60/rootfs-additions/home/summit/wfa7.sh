#!/bin/sh

 nmcli conn add con-name wfa7 ifname wlan0 type wifi ssid wfa7 \
 802-11-wireless-security.key-mgmt wpa-psk \
 802-11-wireless-security.psk arkansas \
 802-11-wireless.band a \
 802-11-wireless.channel 36 \
 802-11-wireless.powersave disable
