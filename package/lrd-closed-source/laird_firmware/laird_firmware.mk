LAIRD_FIRMWARE_VERSION = local
LAIRD_FIRMWARE_SITE = package/lrd-closed-source/externals/firmware
LAIRD_FIRMWARE_SITE_METHOD = local
LAIRD_ADD_SOM_SYMLINK = y

BRCM_DIR = $(TARGET_DIR)/lib/firmware/brcm

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_AR6003),y)
define LAIRD_FW_6003_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/ath6k
	cp -r $(@D)/ath6k/AR6003 $(TARGET_DIR)/lib/firmware/ath6k
	rm $(TARGET_DIR)/lib/firmware/ath6k/AR6003/hw2.1.1/athtcmd*
	rm -rf $(TARGET_DIR)/lib/firmware/ath6k/AR6003/hw2.1.1/info/
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_AR6003_MFG),y)
define LAIRD_FW_6003_MFG_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/ath6k/AR6003/hw2.1.1
	cp $(@D)/ath6k/AR6003/hw2.1.1/athtcmd* $(TARGET_DIR)/lib/firmware/ath6k/AR6003/hw2.1.1/
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_AR6004),y)
define LAIRD_FW_6004_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/ath6k
	cp -r $(@D)/ath6k/AR6004 $(TARGET_DIR)/lib/firmware/ath6k
	rm $(TARGET_DIR)/lib/firmware/ath6k/AR6004/hw3.0/qca*
	rm $(TARGET_DIR)/lib/firmware/ath6k/AR6004/hw3.0/utf*
	rm -rf $(TARGET_DIR)/lib/firmware/ath6k/AR6004/hw3.0/info/
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_AR6004_MFG),y)
define LAIRD_FW_6004_MFG_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/ath6k/AR6004/hw3.0
	cp $(@D)/ath6k/AR6004/hw3.0/utf* $(TARGET_DIR)/lib/firmware/ath6k/AR6004/hw3.0/
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_AR6004_PUBLIC),y)
define LAIRD_FW_6004_PUBLIC_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/ath6k/AR6004/hw3.0
	$(INSTALL) -D -m 0644 $(@D)/ath6k/AR6004/hw3.0/qca* $(TARGET_DIR)/lib/firmware/ath6k/AR6004/hw3.0/
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4343),y)
define LAIRD_FW_BCM4343_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(BRCM_DIR)
	cp -rad $(@D)/brcm/brcmfmac43430-sdio-prod.bin $(BRCM_DIR)
	cp -rad $(@D)/brcm/brcmfmac43430-sdio.bin $(BRCM_DIR)
	cp -rad $(@D)/brcm/brcmfmac43430-sdio*.txt $(BRCM_DIR)
	cp -rad $(@D)/brcm/brcmfmac43430-sdio.clm_blob $(BRCM_DIR)
	cp -rad $(@D)/brcm/BCM43430A1.hcd $(BRCM_DIR)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4343_MFG),y)
define LAIRD_FW_BCM4343_MFG_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(BRCM_DIR)
	cp -rad $(@D)/brcm/brcmfmac43430-sdio-mfg.bin $(BRCM_DIR)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4339),y)
define LAIRD_FW_BCM4339_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(BRCM_DIR)
	cp -rad $(@D)/brcm/brcmfmac4339-sdio-prod.bin $(BRCM_DIR)
	cp -rad $(@D)/brcm/brcmfmac4339-sdio.bin $(BRCM_DIR)
	cp -rad $(@D)/brcm/brcmfmac4339-sdio*.txt $(BRCM_DIR)
	cp -rad $(@D)/brcm/BCM4335C0.hcd $(BRCM_DIR)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4339_MFG),y)
define LAIRD_FW_BCM4339_MFG_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(BRCM_DIR)
	cp -rad $(@D)/brcm/brcmfmac4339-sdio-mfg.bin $(BRCM_DIR)
endef
endif

NVRAM_FILE = $(@D)/brcm/brcmfmac4373-$(1)-$(2).txt
FW_BASE_FILE = $(@D)/brcm/brcmfmac4373-usb-base-$(1).bin
FW_FINAL_FILE = $(BRCM_DIR)/brcmfmac4373-usb-$(1)-$(2)-$(3).bin
FW_FINAL_FILE_MFG = $(BRCM_DIR)/brcmfmac4373-usb-$(1)-$(3).bin

define make_bcm4373usb_fw
	mkdir -p -m 0755 $(BRCM_DIR)
	cp -rad $(@D)/brcm/brcmfmac4373-clm-$(1).clm_blob $(BRCM_DIR)
	cd $(BRCM_DIR) && ln -srf brcmfmac4373-clm-$(1).clm_blob brcmfmac4373.clm_blob
	cp -rad $(@D)/brcm/BCM4373A0-usb-$(1).hcd $(BRCM_DIR)
	cd $(BRCM_DIR) && ln -srf BCM4373A0-usb-$(1).hcd BCM4373A0-04b4-640c.hcd
	grep -v NVRAMRev $(call NVRAM_FILE,$(1),$(2)) > $(BRCM_DIR)/tmp_nvram.txt
	$(@D)/brcm/bin/nvserial -a -o $(BRCM_DIR)/tmp_nvram.nvm $(BRCM_DIR)/tmp_nvram.txt
	$(@D)/brcm/bin/trxv2 -f 0x20 \
		-x $$(stat -c %s $(call FW_BASE_FILE,$(3))) \
		-x 0x160881 \
		-x $$(stat -c %s $(BRCM_DIR)/tmp_nvram.nvm) \
		-o $(call FW_FINAL_FILE,$(1),$(2),$(3)) \
		$(call FW_BASE_FILE,$(3)) $(BRCM_DIR)/tmp_nvram.nvm
	rm -f $(BRCM_DIR)/tmp_nvram.*
	[[ $(3) = prod ]] || (cd $(BRCM_DIR) && mv $(FW_FINAL_FILE) $(FW_FINAL_FILE_MFG))
	[[ $(3) = mfg ]] || (cd $(BRCM_DIR) && ln -srf brcmfmac4373-usb-$(1)-$(2)-prod.bin brcmfmac4373.bin)
endef

define make_bcm4373sdio_fw
	mkdir -p -m 0755 $(BRCM_DIR)
	cp -rad $(@D)/brcm/brcmfmac4373-clm-$(1).clm_blob $(BRCM_DIR)
	cd $(BRCM_DIR) && ln -srf brcmfmac4373-clm-$(1).clm_blob brcmfmac4373-sdio.clm_blob
	cp -rad $(@D)/brcm/BCM4373A0-sdio-$(1).hcd $(BRCM_DIR)
	cd $(BRCM_DIR) && ln -srf BCM4373A0-sdio-$(1).hcd BCM4373A0.hcd
	cp -rad $(@D)/brcm/brcmfmac4373-$(1)-$(2).txt $(BRCM_DIR)
	cd $(BRCM_DIR) && ln -srf brcmfmac4373-$(1)-$(2).txt brcmfmac4373-sdio.txt
	cp -rad $(@D)/brcm/brcmfmac4373-sdio-prod.bin $(BRCM_DIR)
	cd $(BRCM_DIR) && ln -srf brcmfmac4373-sdio-prod.bin brcmfmac4373-sdio.bin
endef

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_SDIO_DIV_FCC),y)
define LAIRD_FW_BCM4373_SDIO_DIV_FCC_INSTALL_TARGET_CMDS
	$(call make_bcm4373sdio_fw,div,fcc)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_SDIO_SA_FCC),y)
define LAIRD_FW_BCM4373_SDIO_SA_FCC_INSTALL_TARGET_CMDS
	$(call make_bcm4373sdio_fw,sa,fcc)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_USB_DIV_FCC),y)
define LAIRD_FW_BCM4373_USB_DIV_FCC_INSTALL_TARGET_CMDS
	$(call make_bcm4373usb_fw,div,fcc,prod)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_USB_SA_FCC),y)
define LAIRD_FW_BCM4373_USB_SA_FCC_INSTALL_TARGET_CMDS
	$(call make_bcm4373usb_fw,sa,fcc,prod)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_SDIO_DIV_IC),y)
define LAIRD_FW_BCM4373_SDIO_DIV_IC_INSTALL_TARGET_CMDS
	$(call make_bcm4373sdio_fw,div,ic)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_SDIO_SA_IC),y)
define LAIRD_FW_BCM4373_SDIO_SA_IC_INSTALL_TARGET_CMDS
	$(call make_bcm4373sdio_fw,sa,ic)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_USB_DIV_IC),y)
define LAIRD_FW_BCM4373_USB_DIV_IC_INSTALL_TARGET_CMDS
	$(call make_bcm4373usb_fw,div,ic,prod)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_USB_SA_IC),y)
define LAIRD_FW_BCM4373_USB_SA_IC_INSTALL_TARGET_CMDS
	$(call make_bcm4373usb_fw,sa,ic,prod)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_SDIO_DIV_ETSI),y)
define LAIRD_FW_BCM4373_SDIO_DIV_ETSI_INSTALL_TARGET_CMDS
	$(call make_bcm4373sdio_fw,div,etsi)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_SDIO_SA_ETSI),y)
define LAIRD_FW_BCM4373_SDIO_SA_ETSI_INSTALL_TARGET_CMDS
	$(call make_bcm4373sdio_fw,sa,etsi)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_USB_DIV_ETSI),y)
define LAIRD_FW_BCM4373_USB_DIV_ETSI_INSTALL_TARGET_CMDS
	$(call make_bcm4373usb_fw,div,etsi,prod)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_USB_SA_ETSI),y)
define LAIRD_FW_BCM4373_USB_SA_ETSI_INSTALL_TARGET_CMDS
	$(call make_bcm4373usb_fw,sa,etsi,prod)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_SDIO_DIV_JP),y)
define LAIRD_FW_BCM4373_SDIO_DIV_JP_INSTALL_TARGET_CMDS
	$(call make_bcm4373sdio_fw,div,jp)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_SDIO_SA_JP),y)
define LAIRD_FW_BCM4373_SDIO_SA_JP_INSTALL_TARGET_CMDS
	$(call make_bcm4373sdio_fw,sa,jp)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_USB_DIV_JP),y)
define LAIRD_FW_BCM4373_USB_DIV_JP_INSTALL_TARGET_CMDS
	$(call make_bcm4373usb_fw,div,jp,prod)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_USB_SA_JP),y)
define LAIRD_FW_BCM4373_USB_SA_JP_INSTALL_TARGET_CMDS
	$(call make_bcm4373usb_fw,sa,jp,prod)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_SDIO_DIV_AU),y)
define LAIRD_FW_BCM4373_SDIO_DIV_AU_INSTALL_TARGET_CMDS
	$(call make_bcm4373sdio_fw,div,au)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_SDIO_SA_AU),y)
define LAIRD_FW_BCM4373_SDIO_SA_AU_INSTALL_TARGET_CMDS
	$(call make_bcm4373sdio_fw,sa,au)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_USB_DIV_AU),y)
define LAIRD_FW_BCM4373_USB_DIV_AU_INSTALL_TARGET_CMDS
	$(call make_bcm4373usb_fw,div,au,prod)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_USB_SA_AU),y)
define LAIRD_FW_BCM4373_USB_SA_AU_INSTALL_TARGET_CMDS
	$(call make_bcm4373usb_fw,sa,au,prod)
endef
endif

# Note - A custom NVRAM file is used for SDIO and USB diversity mfg firmware
#        to disable software diversity and allow manual antenna control
#
#        The NVRAM file is included directly in the regulatory package for SDIO and
#        is also used to build the USB diversity mfg firmware
#        An existing single antenna NVRAM file from any domain can be used to build
#        USB single antenna mfg firmware
ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BCM4373_MFG),y)
define LAIRD_FW_BCM4373_MFG_INSTALL_TARGET_CMDS
	$(call make_bcm4373usb_fw,div,mfg,mfg)
	$(call make_bcm4373usb_fw,sa,fcc,mfg)
	cp -rad $(@D)/brcm/brcmfmac4373-sdio-mfg.bin $(BRCM_DIR)
	cp -rad $(@D)/brcm/brcmfmac4373-div-mfg.txt $(BRCM_DIR)
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_LRDMWL_ST60_SDIO_UART),y)
define LAIRD_FW_LRDMWL_ST60_SDIO_UART_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/lrdmwl
	cp -P $(@D)/lrdmwl/ST/88W8997_ST_sdio_uart_*.bin $(TARGET_DIR)/lib/firmware/lrdmwl
	cd $(TARGET_DIR)/lib/firmware/lrdmwl/ && ln -sf 88W8997_ST_sdio_uart_*.bin 88W8997_sdio.bin
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_LRDMWL_ST60_SDIO_SDIO),y)
define LAIRD_FW_LRDMWL_ST60_SDIO_SDIO_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/lrdmwl
	cp -P $(@D)/lrdmwl/ST/88W8997_ST_sdio_sdio_*.bin $(TARGET_DIR)/lib/firmware/lrdmwl
	cd $(TARGET_DIR)/lib/firmware/lrdmwl/ && ln -sf 88W8997_ST_sdio_sdio_*.bin 88W8997_sdio.bin
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_LRDMWL_ST60_PCIE_UART),y)
define LAIRD_FW_LRDMWL_ST60_PCIE_UART_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/lrdmwl
	cp -P $(@D)/lrdmwl/ST/88W8997_ST_pcie_uart_*.bin $(TARGET_DIR)/lib/firmware/lrdmwl
	cd $(TARGET_DIR)/lib/firmware/lrdmwl/ && ln -sf 88W8997_ST_pcie_uart_*.bin 88W8997_pcie.bin
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_LRDMWL_ST60_PCIE_USB),y)
define LAIRD_FW_LRDMWL_ST60_PCIE_USB_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/lrdmwl
	cp -P $(@D)/lrdmwl/ST/88W8997_ST_pcie_usb_*.bin $(TARGET_DIR)/lib/firmware/lrdmwl
	cd $(TARGET_DIR)/lib/firmware/lrdmwl/ && ln -sf 88W8997_ST_pcie_usb_*.bin 88W8997_pcie.bin
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_LRDMWL_ST60_USB_UART),y)
define LAIRD_FW_LRDMWL_ST60_USB_UART_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/lrdmwl
	cp -P $(@D)/lrdmwl/ST/88W8997_ST_usb_uart_*.bin $(TARGET_DIR)/lib/firmware/lrdmwl
	cd $(TARGET_DIR)/lib/firmware/lrdmwl/ && ln -sf 88W8997_ST_usb_uart_*.bin 88W8997_usb.bin
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_LRDMWL_ST60_USB_USB),y)
define LAIRD_FW_LRDMWL_ST60_USB_USB_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/lrdmwl
	cp -P $(@D)/lrdmwl/ST/88W8997_ST_usb_usb_*.bin $(TARGET_DIR)/lib/firmware/lrdmwl
	cd $(TARGET_DIR)/lib/firmware/lrdmwl/ && ln -sf 88W8997_ST_usb_usb_*.bin 88W8997_usb.bin
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_LRDMWL_SU60_SDIO_UART),y)
define LAIRD_FW_LRDMWL_SU60_SDIO_UART_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/lrdmwl
	cp -P $(@D)/lrdmwl/SU/88W8997_SU_sdio_uart_*.bin $(TARGET_DIR)/lib/firmware/lrdmwl
	cd $(TARGET_DIR)/lib/firmware/lrdmwl/ && ln -sf 88W8997_SU_sdio_uart_*.bin 88W8997_sdio.bin
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_LRDMWL_SU60_SDIO_SDIO),y)
define LAIRD_FW_LRDMWL_SU60_SDIO_SDIO_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/lrdmwl
	cp -P $(@D)/lrdmwl/SU/88W8997_SU_sdio_sdio_*.bin $(TARGET_DIR)/lib/firmware/lrdmwl
	cd $(TARGET_DIR)/lib/firmware/lrdmwl/ && ln -sf 88W8997_SU_sdio_sdio_*.bin 88W8997_sdio.bin
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_LRDMWL_SU60_PCIE_UART),y)
define LAIRD_FW_LRDMWL_SU60_PCIE_UART_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/lrdmwl
	cp -P $(@D)/lrdmwl/SU/88W8997_SU_pcie_uart_*.bin $(TARGET_DIR)/lib/firmware/lrdmwl
	cd $(TARGET_DIR)/lib/firmware/lrdmwl/ && ln -sf 88W8997_SU_pcie_uart_*.bin 88W8997_pcie.bin
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_LRDMWL_SU60_PCIE_USB),y)
define LAIRD_FW_LRDMWL_SU60_PCIE_USB_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/lrdmwl
	cp -P $(@D)/lrdmwl/SU/88W8997_SU_pcie_usb_*.bin $(TARGET_DIR)/lib/firmware/lrdmwl
	cd $(TARGET_DIR)/lib/firmware/lrdmwl/ && ln -sf 88W8997_SU_pcie_usb_*.bin 88W8997_pcie.bin
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_LRDMWL_SU60_USB_UART),y)
define LAIRD_FW_LRDMWL_SU60_USB_UART_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/lrdmwl
	cp -P $(@D)/lrdmwl/SU/88W8997_SU_usb_uart_*.bin $(TARGET_DIR)/lib/firmware/lrdmwl
	cd $(TARGET_DIR)/lib/firmware/lrdmwl/ && ln -sf 88W8997_SU_usb_uart_*.bin 88W8997_usb.bin
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_LRDMWL_SU60_USB_USB),y)
define LAIRD_FW_LRDMWL_SU60_USB_USB_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/lrdmwl
	cp -P $(@D)/lrdmwl/SU/88W8997_SU_usb_usb_*.bin $(TARGET_DIR)/lib/firmware/lrdmwl
	cd $(TARGET_DIR)/lib/firmware/lrdmwl/ && ln -sf 88W8997_SU_usb_usb_*.bin 88W8997_usb.bin
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_LRDMWL_SOM60),y)
#if building MFG SOM and ST or SU fw included, don't set symlink to point to SOM
ifeq ($(findstring som60sd_mfg, $(BR2_DEFCONFIG)),som60sd_mfg)
ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_LRDMWL_SU60_SDIO_UART),y)
	LAIRD_ADD_SOM_SYMLINK = n
else ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_LRDMWL_ST60_SDIO_UART),y)
	LAIRD_ADD_SOM_SYMLINK = n
endif
endif

ifeq ($(LAIRD_ADD_SOM_SYMLINK),y)
define LAIRD_FW_LRDMWL_SOM60_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/lrdmwl
	cp -P $(@D)/lrdmwl/SOM/88W8997_SOM_sdio_uart_*.bin $(TARGET_DIR)/lib/firmware/lrdmwl
	cd $(TARGET_DIR)/lib/firmware/lrdmwl/ && ln -sf 88W8997_SOM_sdio_uart_*.bin 88W8997_sdio.bin
endef
else
define LAIRD_FW_LRDMWL_SOM60_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/lrdmwl
	cp -P $(@D)/lrdmwl/SOM/88W8997_SOM_sdio_uart_*.bin $(TARGET_DIR)/lib/firmware/lrdmwl
endef
endif
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_LRDMWL_SD8997_MFG),y)
define LAIRD_FW_LRDMWL_SD8997_MFG_INSTALL_TARGET_CMDS
	rm -r -f $(TARGET_DIR)/lib/firmware/lrdmwl/mfg/*
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/lrdmwl
	cp $(@D)/lrdmwl/mfg/* $(TARGET_DIR)/lib/firmware/lrdmwl
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_MRVL_SD8997),y)
define LAIRD_FW_MRVL_SD8997_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware/mrvl
	rm -r -f $(TARGET_DIR)/lib/firmware/mrvl/*
	cp -r $(@D)/mrvl/ $(TARGET_DIR)/lib/firmware
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_WL18XX),y)
define LAIRD_FW_WL18XX_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware
	cp -r $(@D)/ti-connectivity $(TARGET_DIR)/lib/firmware
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_BT),y)
define LAIRD_FW_BT50_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware
	cp -r $(@D)/bluetopia $(TARGET_DIR)/lib/firmware
endef
endif

ifeq ($(BR2_PACKAGE_LAIRD_FIRMWARE_AR9271),y)
define LAIRD_FW_AR9271_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/lib/firmware
	cp -r $(@D)/ath9k_htc $(TARGET_DIR)/lib/firmware
endef
endif

define LAIRD_FIRMWARE_INSTALL_TARGET_CMDS
	$(LAIRD_FW_6003_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_6003_MFG_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_6004_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_6004_MFG_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_6004_PUBLIC_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4343_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4343_MFG_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4339_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4339_MFG_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_SDIO_DIV_FCC_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_SDIO_SA_FCC_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_USB_DIV_FCC_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_USB_SA_FCC_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_SDIO_DIV_IC_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_SDIO_SA_IC_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_USB_DIV_IC_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_USB_SA_IC_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_SDIO_DIV_ETSI_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_SDIO_SA_ETSI_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_USB_DIV_ETSI_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_USB_SA_ETSI_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_SDIO_DIV_JP_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_SDIO_SA_JP_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_USB_DIV_JP_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_USB_SA_JP_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_SDIO_DIV_AU_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_SDIO_SA_AU_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_USB_DIV_AU_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_USB_SA_AU_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BCM4373_MFG_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_LRDMWL_ST60_SDIO_UART_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_LRDMWL_ST60_SDIO_SDIO_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_LRDMWL_ST60_PCIE_UART_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_LRDMWL_ST60_PCIE_USB_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_LRDMWL_ST60_USB_UART_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_LRDMWL_ST60_USB_USB_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_LRDMWL_SU60_SDIO_UART_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_LRDMWL_SU60_SDIO_SDIO_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_LRDMWL_SU60_PCIE_UART_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_LRDMWL_SU60_PCIE_USB_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_LRDMWL_SU60_USB_UART_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_LRDMWL_SU60_USB_USB_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_LRDMWL_SOM60_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_LRDMWL_SD8997_MFG_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_MRVL_SD8997_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_WL18XX_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_BT50_INSTALL_TARGET_CMDS)
	$(LAIRD_FW_AR9271_INSTALL_TARGET_CMDS)
endef

$(eval $(generic-package))
