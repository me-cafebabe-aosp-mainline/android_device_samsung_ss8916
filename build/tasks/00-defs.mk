#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

ifeq ($(USES_DEVICE_SAMSUNG_SS8916),true)

# Image sizes in bytes: 13 MiB boot, 300 MiB cache and 4 GiB userdata partitions
SS8916_BOOT_IMAGE_MAX_SIZE ?= 13631488
SS8916_CACHE_IMAGE_SIZE ?= 314572800
SS8916_USERDATA_IMAGE_SIZE ?= 4294967296

# The directory in the userdata image that holds the Android files,
# see androidboot.android_dir in generic_init
SS8916_ANDROID_DIR := android

SS8916_IMAGES_WORKDIR := $(TARGET_OUT_INTERMEDIATES)/SS8916_IMAGES

INSTALLED_SS8916_CACHEIMAGE_TARGET := $(PRODUCT_OUT)/ss8916-cache.img
INSTALLED_SS8916_USERDATAIMAGE_TARGET := $(PRODUCT_OUT)/ss8916-userdata.img

endif # USES_DEVICE_SAMSUNG_SS8916
