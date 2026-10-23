#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

ifeq ($(USES_DEVICE_SAMSUNG_SS8916),true)

##### All images to flash to the real partitions #####

SS8916_FLASH_IMAGES := \
    $(INSTALLED_LK2NDIMAGE_TARGET) \
    $(INSTALLED_SS8916_CACHEIMAGE_TARGET) \
    $(INSTALLED_SS8916_USERDATAIMAGE_TARGET) \
    $(INSTALLED_FASTBOOT_INFO_TARGET)

# Not a file target, so that the size is checked on every run
.PHONY: ss8916-check-lk2nd-size
ss8916-check-lk2nd-size: $(INSTALLED_LK2NDIMAGE_TARGET)
	@size=$$(stat -c %s $(INSTALLED_LK2NDIMAGE_TARGET)); \
	if [ $$size -gt $(SS8916_BOOT_IMAGE_MAX_SIZE) ]; then \
		echo "$(INSTALLED_LK2NDIMAGE_TARGET) ($$size bytes) does not fit in the boot partition ($(SS8916_BOOT_IMAGE_MAX_SIZE) bytes)"; \
		exit 1; \
	fi

# Flash all of them with: fastboot flashall (from $(PRODUCT_OUT))
.PHONY: ss8916-images
ss8916-images: $(SS8916_FLASH_IMAGES) ss8916-check-lk2nd-size
	@echo "Flash with: ANDROID_PRODUCT_OUT=$(PRODUCT_OUT) fastboot flashall"

endif # USES_DEVICE_SAMSUNG_SS8916
