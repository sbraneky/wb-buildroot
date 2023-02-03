#!/bin/sh

FW=x

base=$(ls /lib/modules)
k=$(ls /lib/modules/$base/backports)

if [ "$k" = "" ] ; then
	k=kernel
else
	k=backports
fi

case $1 in
 43) FW=P43;;
 41) FW=P41;;
 24) FW=P24;;
 22) FW=P22;;
  D) FW=DBG;;
  d) FW=DBG;;
  m) FW=MFG;;
  M) fw=MFG;;
esac

if [ "$FW" = "P20" ] 
then
	echo "Using P20"
	rm /lib/firmware/lrdmwl/88W8997_sdio.bin
	cp /home/summit/88W8997_sdio_sdio_v8.5.2.20.bin /lib/firmware/lrdmwl/.
	ln -s /lib/firmware/lrdmwl/88W8997_sdio_sdio_v8.5.2.20.bin /lib/firmware/lrdmwl/88W8997_sdio.bin
else
if [ "$FW" = "P22" ]
then
	echo "Using P22"
	rm /lib/firmware/lrdmwl/88W8997_sdio.bin
	cp /home/summit/88W8997_sdio_sdio_v8.5.2.20.bin /lib/firmware/lrdmwl/.
	ln -s /lib/firmware/lrdmwl/88W8997_sdio_sdio_v8.5.2.20.bin /lib/firmware/lrdmwl/88W8997_sdio.bin
else
if [ "$FW" = "P24" ]
then
	echo "Using P24"
	rm /lib/firmware/lrdmwl/88W8997_sdio.bin
	cp /home/summit/88W8997_sdio_sdio_v8.5.3.24.bin /lib/firmware/lrdmwl/.
	ln -s /lib/firmware/lrdmwl/88W8997_sdio_sdio_v8.5.3.24.bin /lib/firmware/lrdmwl/88W8997_sdio.bin
else
if [ "$FW" = "P41" ]
then
	echo "Using P41"
	rm /lib/firmware/lrdmwl/88W8997_sdio.bin
	cp /home/summit/88W8997_sdio_uart_v8.5.8.41.bin /lib/firmware/lrdmwl/.
	ln -s /lib/firmware/lrdmwl/88W8997_sdio_uart_v8.5.8.41.bin /lib/firmware/lrdmwl/88W8997_sdio.bin
else
if [ "$FW" = "P43" ]
then
	echo "Using P43"
	rm /lib/firmware/lrdmwl/88W8997_sdio.bin
	cp /home/summit/88W8997_sdio_uart_v8.5.9.43.bin /lib/firmware/lrdmwl/.
	ln -s /lib/firmware/lrdmwl/88W8997_sdio_uart_v8.5.9.43.bin /lib/firmware/lrdmwl/88W8997_sdio.bin
else
if [ "$FW"  = "DBG" ]
then
	echo "Using DBG"
	rm /lib/firmware/lrdmwl/88W8997_sdio.bin
	cp /home/summit/88W8997_debug.bin /lib/firmware/lrdmwl/.
	ln -s /lib/firmware/lrdmwl/88W8997_debug.bin /lib/firmware/lrdmwl/88W8997_sdio.bin
else
if [ "$FW" = "MFG" ]
then
	echo "Using MFG"
	rm /lib/firmware/lrdmwl/88W8997_sdio_mfg.bin
	cp /home/summit/_mfg/sdio8997_sdio_combo_251.bin /lib/firmware/lrdmwl/.
	ln -s /lib/firmware/lrdmwl/sdio8997_sdio_combo_251.bin /lib/firmware/lrdmwl/88W8997_sdio_mfg.bin
else
	echo "Using Default"
fi
fi
fi
fi
fi
fi
fi

killall NetworkManager
killall wpa_supplicant 

#dmesg -C
#modprobe lrdmwl_sdio
if [ -f /lib/modules/$base/$k/compat/compat.ko ]; then
insmod /lib/modules/$base/$k/compat/compat.ko
fi
insmod /lib/modules/$base/$k/net/wireless/cfg80211.ko
insmod /lib/modules/$base/$k/net/mac80211/mac80211.ko
insmod /lib/modules/$base/$k/drivers/net/wireless/laird/lrdmwl/lrdmwl.ko lrd_debug=0
insmod /lib/modules/$base/$k/drivers/net/wireless/laird/lrdmwl/lrdmwl_sdio.ko
#insmod /lib/modules/$base/$k/drivers/net/wireless/laird/lrdmwl/lrdmwl_sdio.ko  reset_pwd_gpio=3
if [ -f /lib/modules/$base/$k/drivers/net/wireless/laird/lrdmwl/lrdmwl_usb.ko ]; then
insmod /lib/modules/$base/$k/drivers/net/wireless/laird/lrdmwl/lrdmwl_usb.ko
fi
#modprobe btmrvl_sdio

