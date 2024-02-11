#!/bin/bash

# Define paths
SCRIPT_DESTINATION="/usr/local/bin/send_heartbeat.sh"
SERVICE_DESTINATION="/etc/systemd/system/heartbeat.service"

# Ensure the script is run as root
if [ "$(id -u)" -ne "0" ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

# Stop the service if it's running
systemctl stop heartbeat.service

# Disable the service to prevent it from starting on boot
systemctl disable heartbeat.service

# Remove the service file and script
rm -f "$SERVICE_DESTINATION"
rm -f "$SCRIPT_DESTINATION"

# Reload systemd to remove the service from the system
systemctl daemon-reload

# Optionally, reset the systemd state for the service to clear out all remnants
systemctl reset-failed heartbeat.service

echo "Heartbeat service uninstalled successfully."
