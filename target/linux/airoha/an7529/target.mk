ARCH:=aarch64
SUBTARGET:=an7529
CPU_TYPE:=cortex-a53
KERNELNAME:=Image dtbs
FEATURES+=source-only

define Target/Description
	Build firmware images for Airoha an7581 ARM based boards.
endef
