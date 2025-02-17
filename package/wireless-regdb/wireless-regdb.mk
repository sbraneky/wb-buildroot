################################################################################
#
# wireless-regdb
#
################################################################################

WIRELESS_REGDB_VERSION = 2022.02.18
WIRELESS_REGDB_SOURCE = wireless-regdb-$(WIRELESS_REGDB_VERSION).tar.xz
WIRELESS_REGDB_SITE = $(BR2_KERNEL_MIRROR)/software/network/wireless-regdb
WIRELESS_REGDB_LICENSE = ISC
WIRELESS_REGDB_LICENSE_FILES = LICENSE
WIRELESS_REGDB_CPE_ID_VENDOR = kernel

ifeq ($(BR2_PACKAGE_CRDA),y)
define WIRELESS_REGDB_INSTALL_CRDA_TARGET_CMDS
	$(INSTALL) -m 644 -D -T $(@D)/regulatory.bin \
		$(TARGET_DIR)/usr/lib/crda/regulatory_default.bin
	ln -rfs $(TARGET_DIR)/usr/lib/crda/regulatory_default.bin \
		$(TARGET_DIR)/usr/lib/crda/regulatory.bin
	$(INSTALL) -m 644 -D -T $(@D)/sforshee.key.pub.pem \
		$(TARGET_DIR)/etc/wireless-regdb/pubkeys/sforshee.key.pub.pem
endef
endif

define WIRELESS_REGDB_INSTALL_TARGET_CMDS
	$(WIRELESS_REGDB_INSTALL_CRDA_TARGET_CMDS)
	$(INSTALL) -m 644 -D -T $(@D)/regulatory.db \
		$(TARGET_DIR)/lib/firmware/regulatory_default.db
	ln -rfs $(TARGET_DIR)/lib/firmware/regulatory_default.db \
		$(TARGET_DIR)/lib/firmware/regulatory.db
	$(INSTALL) -m 644 -D -T $(@D)/regulatory.db.p7s \
		$(TARGET_DIR)/lib/firmware/regulatory.db.p7s
endef

$(eval $(generic-package))
