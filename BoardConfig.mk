#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/penang

# Inherit from motorola sm6375-common
include device/motorola/sm6375-common/BoardConfigCommon.mk

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := penang

# Clang
#TARGET_KERNEL_CLANG_COMPILE := true
#TARGET_COMPILE_WITH_MSM_KERNEL := true
#TARGET_KERNEL_CLANG_VERSION := r450784e

# Kernel
BOARD_KERNEL_CMDLINE += androidboot.hab.product=penang
TARGET_KERNEL_CONFIG := \
    vendor/penang_defconfig \
    vendor/ext_config/moto-holi.config

# Kernel Modules
#BOARD_VENDOR_KERNEL_MODULES := \
#    $(wildcard $(DEVICE_PATH)-kernel/vendor-modules/*.ko)
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load))
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(DEVICE_PATH)/modules.blocklist
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery))
BOOT_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD)
#BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(BOOT_KERNEL_MODULES)

# DT
TARGET_KERNEL_ADDITIONAL_FLAGS += CONFIG_BUILD_ARM64_DT_OVERLAY=y

# Kernel modules - Audio
#TARGET_MODULE_ALIASES += \
#    adsp_loader_dlkm.ko:audio_adsp_loader.ko \
#    apr_dlkm.ko:audio_apr.ko \
#    bolero_cdc_dlkm.ko:audio_bolero_cdc.ko \
#    hdmi_dlkm.ko:audio_hdmi.ko \
#    machine_dlkm.ko:audio_machine_lito.ko \
#    mbhc_dlkm.ko:audio_mbhc.ko \
#    native_dlkm.ko:audio_native.ko \
#    pinctrl_lpi_dlkm.ko:audio_pinctrl_lpi.ko \
#    platform_dlkm.ko:audio_platform.ko \
#    q6_dlkm.ko:audio_q6.ko \
#    q6_notifier_dlkm.ko:audio_q6_notifier.ko \
#    q6_pdr_dlkm.ko:audio_q6_pdr.ko \
#    rx_macro_dlkm.ko:audio_rx_macro.ko \
#    snd_event_dlkm.ko:audio_snd_event.ko \
#    stub_dlkm.ko:audio_stub.ko \
#    swr_ctrl_dlkm.ko:audio_swr_ctrl.ko \
#    swr_dlkm.ko:audio_swr.ko \
#    tx_macro_dlkm.ko:audio_tx_macro.ko \
#    usf_dlkm.ko:audio_usf.ko \
#    va_macro_dlkm.ko:audio_va_macro.ko \
#    wcd937x_dlkm.ko:audio_wcd937x.ko \
#    wcd937x_slave_dlkm.ko:audio_wcd937x_slave.ko \
#    wcd938x_dlkm.ko:audio_wcd938x.ko \
#    wcd938x_slave_dlkm.ko:audio_wcd938x_slave.ko \
#    wcd9xxx_dlkm.ko:audio_wcd9xxx.ko \
#    wcd_core_dlkm.ko:audio_wcd_core.ko \
#    wsa881x_dlkm.ko:audio_wsa881x.ko \
#    wsa883x_dlkm.ko:audio_wsa883x.ko \
#    wsa_macro_dlkm.ko:audio_wsa_macro.ko

# Kernel modules - WLAN
#TARGET_MODULE_ALIASES += \
#    wlan.ko:qca_cld3_wlan.ko

#BOOT_KERNEL_MODULES := \
#    tcpc_sgm7220.ko \
#    tcpc_rt1711h.ko \
#    rt_pd_manager.ko \
#    focaltech_0flash_v2_mmi.ko \
#    nova_0flash_mmi.ko

# HIDL
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(DEVICE_PATH)/device_framework_matrix.xml

# Partitions
BOARD_USERDATAIMAGE_PARTITION_SIZE := 102247673856

ifneq ($(WITH_GMS),true)
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 2327273472
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 1044381696
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE := 780140544
endif
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 4961861632 # ((SUPER_PARTITION_SIZE / 2) - 4194304)
BOARD_SUPER_PARTITION_SIZE := 4965011456

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 90
TARGET_RECOVERY_DEVICE_DIRS += $(DEVICE_PATH)

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):init_penang
TARGET_RECOVERY_DEVICE_MODULES := init_penang

# Security
VENDOR_SECURITY_PATCH := 2023-06-01

# inherit from the proprietary version
include vendor/motorola/penang/BoardConfigVendor.mk
