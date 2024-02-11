#!/bin/bash

# Define paths
SCRIPT_SOURCE="send_heartbeat.sh"
SERVICE_SOURCE="heartbeat.service"
SCRIPT_DESTINATION="/usr/local/bin/send_heartbeat.sh"
SERVICE_DESTINATION="/etc/systemd/system/heartbeat.service"

# Ensure the script is run as root
if [ "$(id -u)" -ne "0" ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

# Copy the script and service file to their destinations
cp "$SCRIPT_SOURCE" "$SCRIPT_DESTINATION"
cp "$SERVICE_SOURCE" "$SERVICE_DESTINATION"

# Make the script executable
chmod +x "$SCRIPT_DESTINATION"

# Reload systemd to recognize the new service
systemctl daemon-reload

# Enable the service to start on boot
systemctl enable heartbeat.service

# Start the service
systemctl start heartbeat.service

echo "Heartbeat service installed and started successfully."
