# RoboPeak/DFRobot 2.8" USB TFT Driver

This binary driver is for Raspbian running Kernel 4.1.6 ( check with `uname -a` )

You should see something like "Linux raspberrypi 4.1.6+"

If not, make sure you're up to date:

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

Unless you're okay with starting it up manuall ( `sudo modprobe rp_usbdisplay` ) You'll also have to make sure that rp_usbdisplay starts automatically by editing `/etc/modules` and adding the line:

```bash
rp_usbdisplay
```

## Manually

Clone this repo.

Copy 4.1.6+/rp_usbdisplay.ko to /lib/modules/4.1.6+/kernel/drivers/video/
Copy 4.1.6-v7+/rp_usbdisplay.ko to /lib/modules/4.1.6-v7+/kernel/drivers/video/

Run `sudo depmod`

Then `modprobe rp_usbdisplay`

Your USB display is now installed and should appear as `/dev/fb1`

The display should go black. Test with: `cat /dev/urandom > /dev/fb1`

## Boot X Desktop On USB Display

Although you'll get little use out of your desktop on the USB display, we've included the configuration file which will get it running. See [/extra](/extra) for more information.
