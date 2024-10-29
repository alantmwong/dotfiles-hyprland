#!/bin/bash

# Define the config file path
config_file="$HOME/.config/hypr/conf/monitors/default.conf"

# Check if the config file exists
if [[ ! -f "$config_file" ]]; then
    echo "Config file not found: $config_file"
    exit 1
fi

# Backup the current configuration file
cp "$config_file" "$config_file.bak"

# Read the current monitor configurations
monitor1_line=$(grep '^monitor=DVI-I-1' "$config_file")
monitor2_line=$(grep '^monitor=DVI-I-2' "$config_file")

# Check if both monitors exist
if [[ -n "$monitor1_line" && -n "$monitor2_line" ]]; then
    # Swap the monitor lines using a temporary placeholder
    sed -i.bak \
        -e 's/^monitor=DVI-I-1/monitor=TEMP_MONITOR/' \
        -e 's/^monitor=DVI-I-2/monitor=DVI-I-1/' \
        -e 's/^monitor=TEMP_MONITOR/monitor=DVI-I-2/' "$config_file"
    echo "Swapped monitors DVI-I-1 and DVI-I-2."
else
    echo "One or both monitors not found in the config."
fi
