#!/bin/sh

 nmcli conn add con-name wfa4 ifname wlan0 type wifi ssid wfa4 \
 802-11-wireless-security.key-mgmt ieee8021x \
 802-11-wireless-security.auth-alg leap \
 802-11-wireless.band a \
 802-11-wireless.channel 36 \
 802-11-wireless-security.leap-username user1 \
 802-11-wireless-security.leap-password user1 \
 802-11-wireless.powersave disable
