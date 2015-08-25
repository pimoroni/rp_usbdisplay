# RoboPeak/DFRobot 2.8" USB TFT Driver

This binary driver is for Raspbian running Kernel 4.1.6 ( check with `uname -a` )

## Installing

```bash
git clone http://github.com/pimoroni/rp_usbdisplay
cd rp_usbdisplay
./install.sh
```

## Manually

Clone this repo.

Copy 4.1.6+/rp_usbdisplay.ko to /lib/modules/4.1.6+/kernel/drivers/video/
Copy 4.1.6-v7+/rp_usbdisplay.ko to /lib/modules/4.1.6-v7+/kernel/drivers/video/

Run `sudo depmod`

Then `modprobe rp_usbdisplay`

Your USB display is now installed and should appear as `/dev/fb1`

The display should go black. Test with: `cat /dev/urandom > /dev/fb1`
