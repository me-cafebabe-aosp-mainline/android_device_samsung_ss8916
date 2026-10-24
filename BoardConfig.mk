#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

USES_DEVICE_SAMSUNG_SS8916 := true

# Inherit from mainline/qcom-common
include device/mainline/qcom-common/BoardConfigMainlineQcomCommon.mk

# A/B
AB_OTA_UPDATER := false

# Bootloader (lk2nd)
BOARD_BOOT_HEADER_VERSION := 2
BOARD_CUSTOM_BOOTIMG := true
BOARD_CUSTOM_BOOTIMG_MK := $(DEVICE_PATH)/mkbootimg.mk
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
TARGET_LK2ND_MAKE_FLAGS := OSVERSION_IN_BOOTIMAGE=1

# Boot parameters
BOARD_KERNEL_CMDLINE := \
    $(MAINLINE_COMMON_ANDROIDBOOT_PARAMS) \
    $(MAINLINE_COMMON_KERNEL_PARAMS) \
    $(MAINLINE_QCOM_KERNEL_PARAMS) \
    $(MAINLINE_QCOM_SOC_ANDROIDBOOT_PARAMS) \
    $(MAINLINE_QCOM_SOC_KERNEL_PARAMS) \
    androidboot.hardware=ss8916 \
    androidboot.verifiedbootstate=orange \
    clk_ignore_unused \
    console=tty0 \
    lk2nd.pass-ramoops=zap \
    pd_ignore_unused

BOARD_KERNEL_CMDLINE += \
    androidboot.android_dir_dev=PARTLABEL=userdata \
    androidboot.init_fatal_pause=true \
    androidboot.mount_firmware=only_android_dir \
    androidboot.mount_system=imgs \
    androidboot.mount_userdata=bind_mount_dir \
    rdinit=/system/bin/generic_init \
    sysctl.kernel.firmware_config.force_sysfs_fallback=1

BOARD_KERNEL_CMDLINE += \
    androidboot.selinux=permissive \
    audit=0

# Display
TARGET_SCREEN_DENSITY := 280

# Fastboot
TARGET_BOARD_FASTBOOT_INFO_FILE := $(DEVICE_PATH)/configs/fastboot/fastboot-info.txt

# Filesystem
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_USE_EXT4 := true

# Kernel
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
TARGET_KERNEL_SOURCE := kernel/mainline/msm8916-mainline

TARGET_DTB_LIST_WILDCARD := \
    qcom/msm8916-samsung-* \
    qcom/msm8929-samsung-* \
    qcom/msm8939-samsung-*

TARGET_KERNEL_CONFIG := msm8916_defconfig

TARGET_KERNEL_CONFIG_EXT := \
    $(DEVICE_PATH)/configs/kernel/fixup.config \
    kernel/mainline/configs/fragments/android-base-pre/common.config \
    kernel/mainline/configs/fragments/android-base-pre/arm64.config \
    kernel/configs/b/android-6.12/android-base.config \
    kernel/mainline/configs/fragments/android-base-conditional/CONFIG_ARM64-y.config \
    kernel/mainline/configs/fragments/common.config \
    kernel/mainline/configs/fragments/y/fbcon.config \
    kernel/mainline/configs/fragments/n/disable-clang-hardening-features.config \
    kernel/mainline/configs/fragments/n/faster-build-time.config

# Kernel modules
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := \
    $(strip $(shell cat $(DEVICE_PATH)/configs/modprobe/modules.load.basic)) \
    $(strip $(shell cat $(DEVICE_PATH)/configs/modprobe/modules.load.drm)) \
    $(strip $(shell cat $(DEVICE_PATH)/configs/modprobe/modules.load.power))
BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD := \
    $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD) \
    $(strip $(shell cat $(DEVICE_PATH)/configs/modprobe/modules.load.input)) \
    $(strip $(shell cat $(DEVICE_PATH)/configs/modprobe/modules.load.leds))
BOARD_VENDOR_KERNEL_MODULES_LOAD := \
    $(BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD)
BOOT_KERNEL_MODULES := \
    $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD)
RECOVERY_KERNEL_MODULES := \
    $(BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD)
TARGET_AUTO_COLLECT_KERNEL_MODULE_DEPS := true

# OTA
TARGET_SKIP_OTA_PACKAGE := true

# Partitions
BOARD_USES_METADATA_PARTITION := true
BOARD_USES_VENDOR_DLKMIMAGE := true
BOARD_SYSTEMIMAGE_EXTFS_INODE_COUNT := -1
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 67108864
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_EXTFS_INODE_COUNT := -1
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_RESERVED_SIZE := 67108864
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/configs/properties/odm.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/configs/properties/vendor.prop

# Recovery
TARGET_RECOVERY_DENSITY := xhdpi
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/configs/fstab/fstab.ss8916
