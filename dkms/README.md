# RPi USB Display
## Dynamic Kernel Module Support

This directory contains a .deb file, plus the source used to build it, for rp_usbdisplay DKMS support.

## Installing

Install with:

```
sudo apt install dkms raspberrypi-kernel-headers
sudo dpkg -i rp-usbdisplay-dkms_1.0_all.deb
```

## Using the module

Once you've installed the module using the package above, you should test it.

Insert the module:

```
sudo modprobe rp_usbdisplay
```

Find which framebuffer (/dev/fbX) device the display is connected to:

```
cat /proc/fb | grep rpusbdisp-fb 
```

And display the test image on the display:

```
zcat shoplogo.fb.gz > /dev/<framebuffer_number>
```

If that works, add the module to `/etc/modules` by adding the line `rp_usbdisplay`.
