# 
# Copyright (C) 2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_o_mr1.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Inherit from Daredevil device
$(call inherit-product, device/nokia/Daredevil/device.mk)

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Verity
PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/platform/soc/c0c4000.sdhci/by-name/system
$(call inherit-product, build/target/product/verity.mk)

# Inherit some common aosp stuff.
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_GAPPS_ARCH := arm64
$(call inherit-product, vendor/aosp/config/common_full_phone.mk)

# A/B updater
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    system

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

# The following modules are included in debuggable builds only.
PRODUCT_PACKAGES_DEBUG += \
    bootctl \
    update_engine_client

# Boot control HAL
PRODUCT_PACKAGES += \
    bootctrl.sdm660

PRODUCT_STATIC_BOOT_CONTROL_HAL := \
    bootctrl.sdm660 \
    libcutils \
    libgptutils \
    libz

# Device identifiers
PRODUCT_NAME := aosp_Daredevil
PRODUCT_BRAND := Nokia
PRODUCT_DEVICE := Daredevil
PRODUCT_MANUFACTURER := HMD Global
PRODUCT_MODEL := Nokia 7.2

PRODUCT_GMS_CLIENTID_BASE := android-nokia

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE="Daredevil" \
    PRODUCT_NAME="Daredevil" \
    PRIVATE_BUILD_DESC="m690-user 10 QKQ1.191014.001 00WW_2_250 release-keys"

BUILD_FINGERPRINT := Nokia/Daredevil_00WW/DDV_sprout:10/QKQ1.191014.001/00WW_2_250:user/release-keys

TARGET_VENDOR := nokia
