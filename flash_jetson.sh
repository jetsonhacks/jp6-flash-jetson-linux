#!/bin/bash
set -e
# Check if the system is running on aarch64 (ARM architecture)
if [ $(arch) == 'aarch64' ]; then
  echo "Error: This script must not be run on an aarch64 host system."
  exit 1
fi

# Check if the directory parameter is provided
if [ -z "$1" ]; then
  echo "Error: Please provide the path to the release directory as a parameter."
  echo "Usage: $0 <release_directory>"
  exit 1
fi

# Navigate to the directory containing flash tools
cd "$1/Linux_for_Tegra/" || exit 1

# Present flashing options to the user
echo "Select the flashing method for your Jetson device:"
echo "1) Jetson Orin Nano Developer Kit (NVMe)"
echo "2) Jetson Orin Nano Developer Kit (USB)"
echo "3) Jetson Orin Nano Developer Kit (SD card)"
echo "4) Jetson Orin Nano Developer Kit with Super Configuration (NVMe)"
echo "5) Jetson Orin Nano Developer Kit with Super Configuration (USB)"
echo "6) Jetson Orin Nano Developer Kit with Super Configuration (SD card)"
echo "7) Jetson AGX Orin Developer Kit (eMMC)"
echo "8) Jetson AGX Orin Developer Kit (NVMe)"
echo "9) Jetson AGX Orin Developer Kit (USB)"
echo "10) Jetson AGX Orin Developer Kit (SD card)"

# Take user input for the flashing method
read -p "Enter the number corresponding to your selection: " FLASH_OPTION

# Execute the corresponding flashing command based on the user's selection
case $FLASH_OPTION in
  1)
    echo "Flashing Jetson Orin Nano Developer Kit (NVMe)..."
    sudo ./tools/kernel_flash/l4t_initrd_flash.sh --external-device nvme0n1p1 -c tools/kernel_flash/flash_l4t_t234_nvme.xml -p "-c bootloader/generic/cfg/flash_t234_qspi.xml" --showlogs --network usb0 jetson-orin-nano-devkit internal
    ;;
  2)
    echo "Flashing Jetson Orin Nano Developer Kit (USB)..."
    sudo ./tools/kernel_flash/l4t_initrd_flash.sh --external-device sda1 -c tools/kernel_flash/flash_l4t_t234_nvme.xml -p "-c bootloader/generic/cfg/flash_t234_qspi.xml" --showlogs --network usb0 jetson-orin-nano-devkit internal
    ;;
  3)
    echo "Flashing Jetson Orin Nano Developer Kit (SD card)..."
    sudo ./tools/kernel_flash/l4t_initrd_flash.sh --external-device mmcblk0p1 -c tools/kernel_flash/flash_l4t_t234_nvme.xml -p "-c bootloader/generic/cfg/flash_t234_qspi.xml" --showlogs --network usb0 jetson-orin-nano-devkit internal
    ;;
  4)
    echo "Flashing Jetson Orin Nano Developer Kit with Super Configuration (NVMe)..."
    sudo ./tools/kernel_flash/l4t_initrd_flash.sh --external-device nvme0n1p1 -c tools/kernel_flash/flash_l4t_t234_nvme.xml -p "-c bootloader/generic/cfg/flash_t234_qspi.xml" --showlogs --network usb0 jetson-orin-nano-devkit-super internal
    ;;
  5)
    echo "Flashing Jetson Orin Nano Developer Kit with Super Configuration (USB)..."
    sudo ./tools/kernel_flash/l4t_initrd_flash.sh --external-device sda1 -c tools/kernel_flash/flash_l4t_t234_nvme.xml -p "-c bootloader/generic/cfg/flash_t234_qspi.xml" --showlogs --network usb0 jetson-orin-nano-devkit-super internal
    ;;
  6)
    echo "Flashing Jetson Orin Nano Developer Kit with Super Configuration (SD card)..."
    sudo ./tools/kernel_flash/l4t_initrd_flash.sh --external-device mmcblk0p1 -c tools/kernel_flash/flash_l4t_t234_nvme.xml -p "-c bootloader/generic/cfg/flash_t234_qspi.xml" --showlogs --network usb0 jetson-orin-nano-devkit-super internal
    ;;
  7)
    echo "Flashing Jetson AGX Orin Developer Kit (eMMC)..."
    sudo ./flash.sh jetson-agx-orin-devkit internal
    ;;
  8)
    echo "Flashing Jetson AGX Orin Developer Kit (NVMe)..."
    sudo ./tools/kernel_flash/l4t_initrd_flash.sh --external-device nvme0n1p1 -c tools/kernel_flash/flash_l4t_t234_nvme.xml --showlogs --network usb0 jetson-agx-orin-devkit external
    ;;
  9)
    echo "Flashing Jetson AGX Orin Developer Kit (USB)..."
    sudo ./tools/kernel_flash/l4t_initrd_flash.sh --external-device sda1 -c tools/kernel_flash/flash_l4t_t234_nvme.xml --showlogs --network usb0 jetson-agx-orin-devkit external
    ;;
  10)
    echo "Flashing Jetson AGX Orin Developer Kit (SD card)..."
    sudo ./tools/kernel_flash/l4t_initrd_flash.sh --external-device mmcblk0p1 -c tools/kernel_flash/flash_l4t_t234_nvme.xml --showlogs --network usb0 jetson-agx-orin-devkit external
    ;;
  *)
    echo "Invalid option selected. Please choose a valid number."
    exit 1
    ;;
esac

echo "Flashing process completed."
