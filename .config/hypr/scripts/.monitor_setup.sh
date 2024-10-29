#!/bin/bash

CONFIG_FILE="$HOME/.config/hypr/conf/monitors/default.conf"

# Function to set monitors when USB-C hub is disconnected
set_single_monitor() {
    sed -i -e '/^monitor=DVI-I-2/c\monitor=DVI-I-2, disable' \
           -e '/^monitor=DVI-I-1/c\monitor=DVI-I-1, disable' \
           -e '/^monitor=eDP-1/c\monitor=eDP-1, 1920x1080, 0x0, 1' \
           "$CONFIG_FILE"
    echo "Set single monitor layout"
    hyprctl reload
}

# Function to set monitors when USB-C hub is connected
set_dual_monitor() {
    sed -i -e '/^monitor=DVI-I-2/c\monitor=DVI-I-2, 1920x1080, 0x0, 1' \
           -e '/^monitor=DVI-I-1/c\monitor=DVI-I-1, 1920x1080, 1920x0, 1' \
           -e '/^monitor=eDP-1/c\monitor=eDP-1, disable' \
           "$CONFIG_FILE"
    echo "Set dual monitor layout"
    sleep 2
    hyprctl reload
}

# Run the appropriate function based on input argument
if [[ "$1" == "connected" ]]; then
    set_dual_monitor
    exec ~/.config/hypr/scripts/wallpaper-restore.sh
elif [[ "$1" == "disconnected" ]]; then
    set_single_monitor
    exec ~/.config/hypr/scripts/wallpaper-restore.sh
fi
