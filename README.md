# RoboPeak/DFRobot 2.8" USB TFT Driver

This is an unmodified compiled, packaged, easy-to-install distribution of the official RoboPeak Mini Display Display driver. It's intended to run on Raspbian Jessie or Wheezy on the Raspberry Pi, and has been compiled for various different kernel versions.

You can find the original source code, and raise issues at https://github.com/robopeak/rpusbdisp

Before installing, make sure you're up to date:

```bash
sudo apt-get update
sudo apt-get upgrade
sudo reboot
```

## Installing

```bash
git clone http://github.com/pimoroni/rp_usbdisplay
cd rp_usbdisplay
./install.sh
```

Unless you're okay with starting it up manually ( `sudo modprobe rp_usbdisplay` ) You'll also have to make sure that rp_usbdisplay starts automatically by editing `/etc/modules` and adding the line:

```bash
rp_usbdisplay
```

### Incompatible Kernel (if install.sh fails)
There are some kernels supported but maybe you don't have a supported version. A quick way to solve that is to check for the latest supported kernel under the drivers directory and find it in the rpi-firmware Github repo (https://github.com/Hexxeh/rpi-firmware). For example you can install the supported kernel 4.4.9 by running the following command
```#run ONLY if installing can't proceed because no supported kernel is used
sudo rpi-update 4ce3f4a00648faaa73c7e7d41ff09be83a25bc0a
sudo reboot
```

## Manually

Clone this repo.

Where `<kernel_version>` is the version of your kernel returned by `uname -a`

Copy `drivers/<kernel_version>/rp_usbdisplay.ko` to `/lib/modules/<kernel_version>/kernel/drivers/video/`
Copy `drivers/<kernel_version>-v7+/rp_usbdisplay.ko` to `/lib/modules/<kernel_version>-v7+/kernel/drivers/video/`

Run `sudo depmod`

Then `modprobe rp_usbdisplay`

Your USB display is now installed and should appear as `/dev/fb1`

The display should go black. Test with: `cat /dev/urandom > /dev/fb1`

## Boot X Desktop On USB Display

Although you'll get little use out of your desktop on the USB display, we've included the configuration file which will get it running. See [/extra](/extra) for more information.
