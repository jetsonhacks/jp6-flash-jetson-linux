#!/bin/bash
set -e
# Check if the system is running on aarch64 (ARM architecture)
if [ $(arch) == 'aarch64' ]; then
  echo "Error: This script must not be run on an aarch64 host system."
  exit 1
fi

# Set the default version
DEFAULT_VERSION="36.4.3"
VERSION="${DEFAULT_VERSION}"

# Supported boards list
declare -A BOARDS
BOARDS=(
  ["1"]="jetson-orin-nano-devkit"
  ["2"]="jetson-orin-nano-devkit-super"
  ["3"]="jetson-agx-orin-devkit"
  ["4"]="jetson-agx-orin-devkit-industrial"
)

# Function to display available boards
function display_boards() {
  echo "Select a board:"
  for key in "${!BOARDS[@]}"; do
    echo "$key) ${BOARDS[$key]}"
  done
}

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

# Ask the user to select a board
display_boards
read -p "Enter the number of your selected board: " BOARD_SELECTION

# Validate the board selection
if [[ -z "${BOARDS[$BOARD_SELECTION]}" ]]; then
  echo "Invalid selection. Please choose a valid board."
  exit 1
fi

# Set Environment Variables based on selection
export L4T_RELEASE_PACKAGE="Jetson_Linux_${VERSION}_aarch64.tbz2"
export SAMPLE_FS_PACKAGE="Tegra_Linux_Sample-Root-Filesystem_${VERSION}_aarch64.tbz2"
export BOARD="${BOARDS[$BOARD_SELECTION]}"

# Output the environment variables set
echo "Environment variables set:"
echo "L4T_RELEASE_PACKAGE=$L4T_RELEASE_PACKAGE"
echo "SAMPLE_FS_PACKAGE=$SAMPLE_FS_PACKAGE"
echo "BOARD=$BOARD"
