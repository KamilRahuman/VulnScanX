#!/bin/bash

# Function to install necessary tools
install_dependencies() {
    echo "Updating package lists..."
    sudo apt update

    echo "Installing required dependencies..."
    sudo apt install -y amass subfinder nmap ffuf nikto volatility osquery snort

    echo "Dependencies installed successfully."
}

# Function to set up the VulnScanX project
setup_vulnscanx() {
    echo "Setting up VulnScanX directories..."

    # Create directory structure if it doesn't exist
    mkdir -p /home/$USER/VulnScanX/Fuzzing

    echo "VulnScanX setup completed successfully."
}

# Function to download fuzzing wordlist
download_fuzzing_wordlist() {
    echo "Downloading fuzzing wordlist..."

    # Example of downloading a wordlist from a reliable source
    wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/common.txt -O /home/$USER/VulnScanX/Fuzzing/all.txt

    echo "Fuzzing wordlist downloaded successfully."
}

# Main installation process
echo "Starting VulnScanX Installation..."

install_dependencies
setup_vulnscanx
download_fuzzing_wordlist

echo "Installation completed successfully. You can now run VulnScanX!"
