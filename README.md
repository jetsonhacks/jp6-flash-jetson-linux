# jp6-flash-jetson-linux
# WIP

These are example scripts for flashing JetPack 6 to a NVIDIA Jetson Orin Developer Kit. The Jetson is flashed from a x86 host machine (see Assumptions).

The scripts are based on the [NVIDIA Jetson Developer Guide - Quick Start Section](https://docs.nvidia.com/jetson/archives/r36.4.3/DeveloperGuide/IN/QuickStart.html#quick-start)

The intent of these scripts is to provide simple examples which you can read through to implement your own scripts for flashing the Jetson in your own environment. Make sure that you read through the Developer Guide Quick Start section. 

##  Assumptions from the Quick Start Guide 

* You have a Jetson developer kit and a separate Linux (Ubuntu 22.04 or Ubuntu 20.04) host system. The host must be x86 architecture (PC desktop or notebook, not Jetson)
* Your Jetson developer kit is powered off and is connected as follows. (Note that your Jetson developer kit may not come with the devices and cables listed below.)

  * Linux host is connected for flashing through the appropriate USB Type-C port of the developer kit.

    * For NVIDIA Jetson AGX Orin Developer Kit, use the USB-C port next to the 40 pin header.

  * Any required USB peripherals such as keyboard and mouse are connected to the Jetson developer. You may use a USB hub for this.
  * A wired Ethernet connection with internet access is connected for installing optional software on the developer kit when Jetson Linux has been installed and is running.
  * A display device or a serial console is connected. A serial console is a terminal program, such as minicom, that runs on the host computer or another connected computer.
  * If flashing the rootfs to an SD card or USB flash drive on Orin NX or Orin Nano, the storage size must be 64GB or larger.


# Running the Scripts
The scripts are run in the following order:

## setup_jetson_env.sh

```
bash setup_jetson_env.sh
```

This sets up the Environment Variables for downloading and flashing: Your host system must be configured to set certain environment variables:

* ${L4T_RELEASE_PACKAGE} contains the name of the Jetson Linux release package.
* ${SAMPLE_FS_PACKAGE} contains the name of the sample file system package.
* ${BOARD} contains the name of a supported configuration of Jetson module and the carrier board. Common values for this field can be found in the Configuration column in the Jetson Modules and Configurations table.
