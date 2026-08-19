include $(TOPDIR)/rules.mk

# THE FIX: This code checks which subtarget is being built
# If it's one of the 64-bit chips, use aarch64. Otherwise, use arm.
ifneq ($(filter en7529 an7581 an7583,$(SUBTARGET)),)
  ARCH:=aarch64
else
  ARCH:=arm
endif

BOARD:=airoha
BOARDNAME:=Airoha ARM
SUBTARGETS:=en7523 en7529 an7581 an7583
FEATURES:=dt squashfs nand ramdisk gpio

KERNEL_PATCHVER:=6.18

include $(INCLUDE_DIR)/target.mk
DEFAULT_PACKAGES += \
	kmod-leds-gpio kmod-gpio-button-hotplug

$(eval $(call BuildTarget))
