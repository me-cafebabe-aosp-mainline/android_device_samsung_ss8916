#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

ifeq ($(USES_DEVICE_SAMSUNG_SS8916),true)

##### cache image: ext2 holding the files lk2nd boots from #####

SS8916_CACHEIMAGE_STAGE := $(SS8916_IMAGES_WORKDIR)/cache
SS8916_CACHEIMAGE_DTB_DIR = $(DTB_OUT)/arch/$(KERNEL_ARCH)/boot/dts

$(INSTALLED_SS8916_CACHEIMAGE_TARGET): \
    $(PRODUCT_OUT)/kernel \
    $(PRODUCT_OUT)/ramdisk.img \
    $(INSTALLED_DTBIMAGE_TARGET) \
    $(HOST_OUT_EXECUTABLES)/mke2fs
	$(call pretty,"Target cache image: $@")
	rm -rf $(SS8916_CACHEIMAGE_STAGE)
	mkdir -p $(SS8916_CACHEIMAGE_STAGE)/extlinux
	cp $(TARGET_PREBUILT_INT_KERNEL) $(SS8916_CACHEIMAGE_STAGE)/Image.gz
	cp $(PRODUCT_OUT)/ramdisk.img $(SS8916_CACHEIMAGE_STAGE)/ramdisk.img
	$(foreach dtb,$(TARGET_DTB_LIST_WILDCARD),\
		mkdir -p $(SS8916_CACHEIMAGE_STAGE)/dtbs/$(dir $(dtb)) && \
		cp $(SS8916_CACHEIMAGE_DTB_DIR)/$(dir $(dtb))$(notdir $(dtb)).dtb $(SS8916_CACHEIMAGE_STAGE)/dtbs/$(dir $(dtb)) &&) true
	printf '%s\n' \
		'default android' \
		'label android' \
		'    linux /Image.gz' \
		'    initrd /ramdisk.img' \
		'    fdtdir /dtbs' \
		'    append $(strip $(BOARD_KERNEL_CMDLINE))' \
		> $(SS8916_CACHEIMAGE_STAGE)/extlinux/extlinux.conf
	rm -f $@
	truncate -s $(SS8916_CACHE_IMAGE_SIZE) $@
	$(HOST_OUT_EXECUTABLES)/mke2fs -t ext2 -O ^resize_inode -b 4096 -I 128 -L cache \
		-E root_owner=0:0 -d $(SS8916_CACHEIMAGE_STAGE) $@

.PHONY: ss8916-cacheimage
ss8916-cacheimage: $(INSTALLED_SS8916_CACHEIMAGE_TARGET)

endif # USES_DEVICE_SAMSUNG_SS8916
