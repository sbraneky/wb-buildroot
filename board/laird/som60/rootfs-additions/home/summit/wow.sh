#!/bin/sh

iw phy$1 wowlan enable net-detect interval 5000 freqs 2412 2417  active ssid foobar

