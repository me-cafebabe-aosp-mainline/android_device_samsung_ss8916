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
    androidboot.selinux=permissive \
    audit=0

# Display
TARGET_SCREEN_DENSITY := 280

# Filesystem
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
    kernel/mainline/configs/fragments/android-base-pre/common.config \
    kernel/mainline/configs/fragments/android-base-pre/arm64.config \
    kernel/configs/b/android-6.12/android-base.config \
    kernel/mainline/configs/fragments/android-base-conditional/CONFIG_ARM64-y.config \
    kernel/mainline/configs/fragments/common.config \
    kernel/mainline/configs/fragments/y/fbcon.config \
    kernel/mainline/configs/fragments/n/disable-clang-hardening-features.config \
    kernel/mainline/configs/fragments/n/faster-build-time.config

# Kernel modules
BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD := \
    $(strip $(shell cat $(DEVICE_PATH)/configs/modprobe/modules.load.basic)) \
    $(strip $(shell cat $(DEVICE_PATH)/configs/modprobe/modules.load.drm)) \
    $(strip $(shell cat $(DEVICE_PATH)/configs/modprobe/modules.load.touchscreen))
BOARD_VENDOR_KERNEL_MODULES_LOAD := \
    $(BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD)
RECOVERY_KERNEL_MODULES := \
    $(BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD)
TARGET_AUTO_COLLECT_KERNEL_MODULE_DEPS := true

# OTA
TARGET_OTA_ASSERT_DEVICE := ss8916

# Partitions
SSI_PARTITIONS := system
TREBLE_PARTITIONS := vendor
ALL_PARTITIONS := $(SSI_PARTITIONS) $(TREBLE_PARTITIONS)

$(foreach p, $(call to-upper, $(ALL_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4) \
    $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

BOARD_USES_METADATA_PARTITION := true

BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_USERDATAIMAGE_PARTITION_SIZE := 10332634112 # 10332650496 - 16384

# Partitions - dynamic
BOARD_SUPER_PARTITION_BLOCK_DEVICES := system
BOARD_SUPER_PARTITION_METADATA_DEVICE := system
BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE := 3221225472
BOARD_SUPER_PARTITION_SIZE := $(BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE)

BOARD_QRD8937_DYNPART_SIZE := $(shell expr $(BOARD_SUPER_PARTITION_SIZE) - 4194304 )
BOARD_QRD8937_DYNPART_PARTITION_LIST := $(ALL_PARTITIONS)
BOARD_SUPER_PARTITION_GROUPS := ss8916_dynpart

# Partitions - reserved size
$(foreach p, $(call to-upper, $(SSI_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_EXTFS_INODE_COUNT := -1))
$(foreach p, $(call to-upper, $(TREBLE_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_EXTFS_INODE_COUNT := 4096))

$(foreach p, $(call to-upper, $(SSI_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_PARTITION_RESERVED_SIZE := 41943040)) # 40 MB
$(foreach p, $(call to-upper, $(TREBLE_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_PARTITION_RESERVED_SIZE := 104857600)) # 100 MB

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/configs/properties/odm.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/configs/properties/vendor.prop

# Ramdisk
BOARD_RAMDISK_USE_LZ4 := true

# Recovery
TARGET_RECOVERY_DENSITY := xhdpi
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/configs/fstab/fstab.ss8916
