#!/bin/bash

success () {
    echo "$(tput setaf 2)$1$(tput sgr0)"
}

warning () {
    echo "$(tput setaf 3)$1$(tput sgr0)"
}

error () {
    echo "$(tput setaf 1)$1$(tput sgr0)"
}

confirm () {
    read -r -p "$1 [y/N] " response < /dev/tty
    response=${response,,}
    if [[ $response =~ ^(yes|y)$ ]]; then
        true
    else
        false
    fi
}

IS_RASPBIAN=`cat /etc/*-release | grep Raspbian`

if [[ "" == $IS_RASPBIAN ]]; then
    warning "Warning!"
    echo "Please only run this script on Raspbian on your Raspberry Pi"
    exit 1;
fi


cat << EOF

Easy Robopeak/DFRobot USB Display Installer v2.0
Written and maintained by Phil @Gadgetoid Howard

Support & Issues: https://github.com/pimoroni/rp_usbdisplay

For best results, please make sure you're running
a supported kernel and that your RFRobot USB display
is plugged in.

EOF

if lsusb | grep -q fccf:a001; then
    success "USB display detected."
else
    warning "USB display not detected, did you plug it in?"
fi
echo ""

if ! confirm "Continue installing?"; then
    exit
fi

echo ""

RUNNING=0

DRIVERS=`find drivers/* -type d | cut -d'/' -f2`

while read filename; do

    echo "Checking for $filename"

    if uname -a | grep -q $filename; then

        success "Detected running kernel $filename"
        RUNNING=1

    fi

    if [ -d "/lib/modules/$filename" ]; then

        warning "Installing driver into /lib/modules/$filename"
        sudo cp drivers/$filename/rp_usbdisplay.ko /lib/modules/$filename/kernel/drivers/video/

    fi
    echo ""

done <<<"$DRIVERS"

if [ $RUNNING -eq 1 ]; then
  
    echo "Updating module dependencies..."
    sudo depmod
    echo ""
  
    echo "Starting driver..."
    sudo modprobe rp_usbdisplay
    sleep 0.5
    echo ""

    echo "Checking for framebuffer..."
    echo ""

    if cat /proc/fb | grep -q rpusbdisp-fb; then

        success "Install Successful!"

        FB=`cat /proc/fb | grep rpusbdisp-fb | awk -F' ' '{print $1}'`
    
        success "RoboPeak USB Display framebuffer found at /dev/fb$FB"
        echo ""
    
        if lsusb | grep -q fccf:a001; then

            echo "Display detected. Testing..."    
            echo ""
            zcat shoplogo.fb.gz > /dev/fb$FB
            sleep 3
            dd if=/dev/zero of=/dev/fb$FB bs=153600 count=1 > /dev/null

        fi

        # echo "To start it on boot, don't forget to edit /etc/modules"
        echo "Adding to /etc/modules..."
        sudo bash -c "echo rp_usbdisplay >> /etc/modules"
        echo "Added"
        
        success "Install finished. Enjoy!"
        echo ""

    else

        warning "No RPUSBDisp framebuffer found, did something go wrong?"

    fi

else

    warning "Sorry. Current running kernel is not supported and binary builds are no longer maintained."
    uname -a
    warning "Please use the DKMS package instead: https://github.com/pimoroni/rp_usbdisplay/tree/master/dkms"

fi
