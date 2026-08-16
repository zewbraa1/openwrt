define Build/en7529-preloader
	$(STAGING_DIR_HOST)/bin/fiptool create \
		--tb-fw $(STAGING_DIR_IMAGE)/en7529-bl2.bin \
		$(STAGING_DIR_IMAGE)/en7529_$1-bl2.fip
	cat $(STAGING_DIR_IMAGE)/en7529_$1-bl2.fip >> $@
endef

define Build/en7529-bl31-uboot
	$(STAGING_DIR_HOST)/bin/fiptool create \
		--soc-fw $(STAGING_DIR_IMAGE)/en7529-bl31.lzma \
		--nt-fw $(STAGING_DIR_IMAGE)/en7529_$1-u-boot.lzma \
		$(STAGING_DIR_IMAGE)/en7529_$1-bl31-u-boot.fip
	cat $(STAGING_DIR_IMAGE)/en7529_$1-bl31-u-boot.fip >> $@
endef

define Device/FitImageLzma
	KERNEL_SUFFIX := -uImage.itb
	KERNEL = kernel-bin | lzma | \
		fit lzma $$(KDIR)/image-$$(DEVICE_DTS).dtb
	KERNEL_NAME := Image
endef

define Device/econet_an7529ct
	$(call Device/FitImageLzma)
	DEVICE_VENDOR := EcoNet
	DEVICE_MODEL := AN7529CT
	DEVICE_DTS := econet-an7529ct
	DEVICE_DTS_CONFIG := config@1
	DEVICE_PACKAGES := kmod-button-hotplug kmod-leds-gpio
	IMAGE/sysupgrade.bin := append-kernel | pad-to 128k | append-rootfs | pad-rootfs | append-metadata
	ARTIFACT/preloader.bin := en7529-preloader an7529ct
	ARTIFACT/bl31-uboot.fip := en7529-bl31-uboot an7529ct
	ARTIFACTS := preloader.bin bl31-uboot.fip
endef
TARGET_DEVICES += econet_an7529ct
