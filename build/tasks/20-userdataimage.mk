#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

ifeq ($(USES_DEVICE_SAMSUNG_SS8916),true)

##### userdata image: f2fs holding the Android directory for generic_init #####

SS8916_USERDATAIMAGE_STAGE := $(SS8916_IMAGES_WORKDIR)/userdata

SS8916_USERDATAIMAGE_IMGS := \
    $(PRODUCT_OUT)/system.img \
    $(PRODUCT_OUT)/vendor.img
ifeq ($(BOARD_USES_VENDOR_DLKMIMAGE),true)
SS8916_USERDATAIMAGE_IMGS += \
    $(PRODUCT_OUT)/vendor_dlkm.img
endif

$(INSTALLED_SS8916_USERDATAIMAGE_TARGET): \
    $(SS8916_USERDATAIMAGE_IMGS) \
    $(HOST_OUT_EXECUTABLES)/make_f2fs \
    $(HOST_OUT_EXECUTABLES)/sload_f2fs
	$(call pretty,"Target userdata image: $@")
	rm -rf $(SS8916_USERDATAIMAGE_STAGE)
	mkdir -p $(SS8916_USERDATAIMAGE_STAGE)/$(SS8916_ANDROID_DIR)/metadata \
		$(SS8916_USERDATAIMAGE_STAGE)/$(SS8916_ANDROID_DIR)/userdata
	$(foreach img,$(SS8916_USERDATAIMAGE_IMGS),\
		ln $(img) $(SS8916_USERDATAIMAGE_STAGE)/$(SS8916_ANDROID_DIR)/ 2>/dev/null || \
		cp $(img) $(SS8916_USERDATAIMAGE_STAGE)/$(SS8916_ANDROID_DIR)/ &&) true
	rm -f $@
	truncate -s $(SS8916_USERDATA_IMAGE_SIZE) $@
	$(HOST_OUT_EXECUTABLES)/make_f2fs -g android -O extra_attr,inode_checksum,sb_checksum,compression \
		-f -l userdata $@
	$(HOST_OUT_EXECUTABLES)/sload_f2fs -f $(SS8916_USERDATAIMAGE_STAGE) -t / $@

.PHONY: ss8916-userdataimage
ss8916-userdataimage: $(INSTALLED_SS8916_USERDATAIMAGE_TARGET)

endif # USES_DEVICE_SAMSUNG_SS8916
