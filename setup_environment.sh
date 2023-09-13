#!/bin/bash

# Function to install a package if not already installed
install_package() {
    local package_name=$1
    if ! dpkg -l | grep -q $package_name; then
        read -p "$package_name is not installed. Do you want to install it? (y/n): " choice
        if [ "$choice" == "y" ]; then
            echo "Installing $package_name..."
            sudo apt-get update
            sudo apt-get install -y $package_name
        else
            echo "Skipping $package_name installation."
        fi
    else
        read -p "$package_name is already installed. Do you want to update it? (y/n): " choice
        if [ "$choice" == "y" ]; then
            echo "Updating $package_name..."
            sudo apt-get update
            sudo apt-get upgrade -y $package_name
        else
            echo "Skipping $package_name update."
        fi
    fi
}

# Update the system
echo "Updating the system..."
sudo apt-get update
sudo apt-get upgrade -y

# Install or update packages
install_package awscli
install_package terraform
install_package git
install_package docker.io
install_package ansible

# Final report
echo ""
echo "Setup complete. Here's the final report:"
echo "----------------------------------------"
echo "AWS CLI:"
aws --version || echo "AWS CLI not installed."
echo ""
echo "Terraform:"
terraform --version || echo "Terraform not installed."
echo ""
echo "Git:"
git --version || echo "Git not installed."
echo ""
echo "Docker:"
docker --version || echo "Docker not installed."
echo ""
echo "Ansible:"
ansible --version || echo "Ansible not installed."
echo ""

# Install additional commonly used commands
echo "Installing additional commands..."
sudo apt-get install -y wget curl jq unzip

echo "Setup of important tools and commands is complete."
