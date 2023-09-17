#!/bin/bash

# Check if the script is running with root privileges
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root. Please use sudo or switch to the root user."
  exit 1
fi

# Check if OpenSSH is already installed
if ! rpm -q openssh-server openssh-clients &>/dev/null; then
  echo "OpenSSH is not installed. Installing..."
  yum install -y openssh-server openssh-clients
else
  echo "OpenSSH is already installed. Updating..."
  yum update -y openssh-server openssh-clients
fi

# Enable and start the OpenSSH server
systemctl enable sshd
systemctl start sshd

# Check if port 22 is allowed in the firewall
if ! firewall-cmd --query-port=22/tcp; then
  echo "Port 22 is not enabled in the firewall. Enabling..."
  firewall-cmd --add-port=22/tcp --permanent
  firewall-cmd --reload
else
  echo "Port 22 is already enabled in the firewall."
fi

echo "OpenSSH installation and configuration complete."
