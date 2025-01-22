#!/bin/bash

# Check if the system is running on aarch64 (ARM architecture)
if [ $(arch) == 'aarch64' ]; then
  echo "Error: This script must not be run on an aarch64 host system."
  exit 1
fi

# Set the default version
DEFAULT_VERSION="36.4.3"
VERSION="${DEFAULT_VERSION}"

# Define the version-specific URLs for BSP and sample root filesystem
declare -A DOWNLOAD_URLS
DOWNLOAD_URLS=(
  ["36.4.3_bsp"]="https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v4.3/release/Jetson_Linux_r36.4.3_aarch64.tbz2"
  ["36.4.3_rootfs"]="https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v4.3/release/Tegra_Linux_Sample-Root-Filesystem_r36.4.3_aarch64.tbz2"
)

# Check if a version is provided as a command-line argument
while getopts "v:" opt; do
  case ${opt} in
    v)
      VERSION="${OPTARG}"  # Set version from command-line argument
      ;;
    *)
      echo "Usage: $0 [-v version]"
      exit 1
      ;;
  esac
done

# Define the file names based on the version
L4T_RELEASE_PACKAGE="Jetson_Linux_${VERSION}_aarch64.tbz2"
SAMPLE_FS_PACKAGE="Tegra_Linux_Sample-Root-Filesystem_${VERSION}_aarch64.tbz2"

# Get the URLs for the BSP and root filesystem based on the version
BSP_URL="${DOWNLOAD_URLS[${VERSION}_bsp]}"
ROOTFS_URL="${DOWNLOAD_URLS[${VERSION}_rootfs]}"

# Check if the URLs are valid
if [[ -z "$BSP_URL" || -z "$ROOTFS_URL" ]]; then
  echo "Error: Invalid version or URLs not found for version $VERSION."
  exit 1
fi

# Create the directory for this release
RELEASE_DIR="R${VERSION}"
mkdir -p "$RELEASE_DIR"

# Download the BSP and sample root filesystem into the release directory
echo "Downloading Jetson Linux BSP..."
wget "$BSP_URL" -O "$RELEASE_DIR/$L4T_RELEASE_PACKAGE"

echo "Downloading sample root filesystem..."
wget "$ROOTFS_URL" -O "$RELEASE_DIR/$SAMPLE_FS_PACKAGE"

# Extract the downloaded files into the created release directory
echo "Extracting Jetson Linux BSP..."
tar -x -p -f "$RELEASE_DIR/$L4T_RELEASE_PACKAGE" -C "$RELEASE_DIR"

echo "Extracting sample root filesystem..."
sudo tar -x -p -f "$RELEASE_DIR/$SAMPLE_FS_PACKAGE" -C "$RELEASE_DIR/Linux_for_Tegra/rootfs/"

echo "Files extracted successfully into $RELEASE_DIR."

# Navigate to the directory containing flash tools
cd "$RELEASE_DIR/Linux_for_Tegra/" || exit 1

if [[ $(lsb_release -rs) == "20.04" ]] ; then
  export LDK_ROOTFS_DIR=$PWD
fi
if [[ $(lsb_release -rs) == "22.04" ]] ; then
  export LDK_ROOTFS_DIR=$PWD
fi

# Prepare prerequisites
echo "Preparing prerequisites..."
sudo ./tools/l4t_flash_prerequisites.sh

# Apply binaries
echo "Applying binaries..."
sudo ./apply_binaries.sh

echo "Prerequisites prepared and binaries applied successfully."
