#!/bin/bash

success () {
  echo "$(tput setaf 2)$1$(tput sgr0)"
}

warning () {
  echo "$(tput setaf 1)$1$(tput sgr0)"
}

IS_RASPBIAN=`cat /etc/*-release | grep Raspbian`

if [[ "" == $IS_RASPBIAN ]]; then
  warning "Warning!"
  echo "Please only run this script on Raspbian on your Raspberry Pi"
  exit 1;
fi

if uname -a | grep -q 4.1.6; then

  if [ -d "/lib/modules/4.1.6+" ]; then
    echo "Installing A/B/B+ support"
    sudo cp 4.1.6+/rp_usbdisplay.ko /lib/modules/4.1.6+/kernel/drivers/video/
  fi

  if [ -d "/lib/modules/4.1.6-v7+" ]; then
    echo "Installing Pi 2 support"
    sudo cp 4.1.6-v7+/rp_usbdisplay.ko /lib/modules/4.1.6-v7+/kernel/drivers/video/
  fi

  echo "Updating module dependencies..."
  sudo depmod

  echo "Starting driver..."
  sudo modprobe rp_usbdisplay
  sleep 0.5
  if [ -c "/dev/fb1" ]; then
    success "Install Successful!"
    echo "You should see the screen fill with noise."
    cat /dev/urandom > /dev/fb1
    sleep 2
    cat /dev/zero > /dev/fb1
    success "Enjoy!"
  else
    warning "No /dev/fb1 found, did something go wrong?"
  fi
else
  echo "Kernel 4.1.6 required"
  echo "Please apt-get update && apt-get upgrade"
fi
