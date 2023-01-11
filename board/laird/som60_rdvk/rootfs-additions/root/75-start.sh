if [ "$1" == "mfg" ]; then
	modprobe sdw61x cal_data_cfg=none mfg_mode=1 fw_name=iw612/sduart_nw61x_v1_mfg.bin.se
else
	modprobe sdw61x cal_data_cfg=none mfg_mode=0 fw_name=iw612/sduart_nw61x_v1.bin.se
fi


