# Xorg Configs

## 10-robopeak.conf

This is a basic configuration file which sets the USB display as the default X display when you run startx.

Copy into /usr/share/X11/xorg.conf.d/

# Command-Line/Console To USB Display

To get the Pi console output onto the USB display, you should edit `/boot/cmdline.txt`;

```bash
sudo nano /boot/cmdline.txt
```

And add the following to the end of the long string you see in this file:

```bash
fbcon=font:ProFont6x11 fbcon=map:1
```

Your X desktop will stil start up as normal on your main display. If you want to switch your keyboard input onto the virtual console on you USB display, press `ctrl+alt+f1` and if you want to switch back to your X desktop press `ctrl+alt+f7`
