#!/bin/bash

# Function to install a package if not already installed
install_package() {
    local package_name=$1
    if ! rpm -q $package_name; then
        read -p "$package_name is not installed. Do you want to install it? (y/n): " choice
        if [ "$choice" == "y" ]; then
            echo "Installing $package_name..."
            sudo yum install -y $package_name
        else
            echo "Skipping $package_name installation."
        fi
    else
        read -p "$package_name is already installed. Do you want to update it? (y/n): " choice
        if [ "$choice" == "y" ]; then
            echo "Updating $package_name..."
            sudo yum update -y $package_name
        else
            echo "Skipping $package_name update."
        fi
    fi
}

# Update the system
echo "Updating the system..."
sudo yum update -y

# Install or update packages
install_package aws-cli
install_package terraform
install_package git
install_package docker
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
sudo yum install -y wget curl jq unzip

echo "Setup of important tools and commands is complete."
