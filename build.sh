#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
    echo "${0} must run this script with root permissions, e.g. 'sudo'"
    exit 1
fi


# If driver is missing get it
if [ ! -f /usr/lib/firmware/rtl_bt/rtl8761bu_fw.bin ]; then
    echo "Missing rtl8761bu_fw.bin"

    if [ ! -f /usr/lib/firmware/rtl_bt/rtl8761b_fw.bin ]; then
        echo "Installing missing rtl8761bu_fw.bin"
        wget --quiet --no-check-certificate --output-document=/usr/lib/firmware/rtl_bt/rtl8761bu_fw.bin https://github.com/Realtek-OpenSource/android_hardware_realtek/blob/rtk1395/bt/rtkbt/Firmware/BT/rtl8761b_fw > /dev/null || exit 1
    else
        ln -s /usr/lib/firmware/rtl_bt/rtl8761b_fw.bin /usr/lib/firmware/rtl_bt/rtl8761bu_fw.bin > /dev/null || exit 1
    fi

fi

if [ ! -f /usr/lib/firmware/rtl_bt/rtl8761bu_config.bin ]; then
    echo "Missing rtl8761bu_config.bin"

    if [ ! -f /usr/lib/firmware/rtl_bt/rtl8761b_config.bin ]; then
        echo "Installing missing rtl8761bu_config.bin"
        wget --quiet --no-check-certificate --output-document=/usr/lib/firmware/rtl_bt/rtl8761bu_config.bin https://github.com/Realtek-OpenSource/android_hardware_realtek/blob/rtk1395/bt/rtkbt/Firmware/BT/rtl8761b_config > /dev/null || exit 1
    else
        ln -s /usr/lib/firmware/rtl_bt/rtl8761b_config.bin /usr/lib/firmware/rtl_bt/rtl8761bu_config.bin > /dev/null || exit 1
    fi

fi