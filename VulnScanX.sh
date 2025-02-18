#!/bin/bash

# Function to display the logo with animation
display_logo() {
    local logo=(
        "____   ____    .__           _________                    ____  ___"
        "\\   \\ /   /_ __|  |   ____  /   _____/ ____ _____    ____ \\   \\/  /"
        " \\   Y   /  |  \\  |  /    \\ \\_____  \\_/ ___\\\\__  \\  /    \\ \\     / "
        "  \\     /|  |  /  |_|   |  \\/        \\  \\___ / __ \\|   |  \\/     \\ "
        "   \\___/ |____/|____/___|  /_______  /\\___  >____  /___|  /___/\\  \\"
        "                         \\/        \\/     \\/     \\/     \\/      \\_/"
    )

    # Animate the logo display
    for line in "${logo[@]}"; do
        echo -e "\033[1;32m$line\033[0m"  # Print each line in green and reset color afterward
        sleep 0.1  # Sleep for 0.1 seconds between lines
    done
    echo
}

# Function to display a loading animation
loading_animation() {
    local pid=$1
    local delay=0.5
    local spin='/-\|'

    echo -n "Loading"
    while ps -p $pid > /dev/null; do
        for i in $(seq 0 3); do
            echo -n "."
            sleep $delay
        done
        echo -ne "\rLoading ${spin:i%${#spin}:1}  "
    done
    echo -ne "\r"  # Clear the loading line
}

# Function to display the menu
display_menu() {
    echo "VulnScanX Pro Suite - All-in-One Cybersecurity Tool"
    echo "----------------------------------------------------"
    echo "1. Subdomain Enumeration"
    echo "2. Sub-IP Scanning"
    echo "3. Fuzzing"
    echo "4. Vulnerability Scanning"
    echo "5. Digital Forensics and Incident Response"
    echo "6. Automated Data Collection"
    echo "7. Anomaly Detection"
    echo "8. Exit"
    echo "----------------------------------------------------"
    echo -n "Select an option [1-8]: "
}

# Function for subdomain enumeration
subdomain_enumeration() {
    echo -n "Enter the domain name to enumerate (e.g., example.com): "
    read domain
    if [ -z "$domain" ]; then
        echo "Error: No domain name provided."
    else
        echo "Running Subdomain Enumeration using Amass and Subfinder..."
        amass enum -d "$domain" -o amass_output.txt &
        loading_animation $!
        subfinder -d "$domain" -o subfinder_output.txt
        echo "Subdomain enumeration completed. Results saved in amass_output.txt and subfinder_output.txt."
    fi
}

# Function for Sub-IP Scanning
sub_ip_scanning() {
    echo -n "Enter the IP range or subnet to scan (e.g., 192.168.1.0/24): "
    read ip_range
    if [ -z "$ip_range" ]; then
        echo "Error: No IP range provided."
    else
        echo "Running Sub-IP Scanning using Nmap..."
        nmap -sP "$ip_range" -oN sub_ip_scan_output.txt &
        loading_animation $!
        echo "Sub-IP scanning completed. Results saved in sub_ip_scan_output.txt."
    fi
}

# Function for Fuzzing
fuzzing() {
    echo -n "Enter the URL to fuzz (e.g., http://example.com): "
    read url
    if [ -z "$url" ]; then
        echo "Error: No URL provided."
    else
        echo "Running Fuzzing using ffuf..."
        ffuf -w /home/kamilbhai/VulnScanX/Fuzzing/all.txt -u "$url/FUZZ" -o fuzzing_output.txt -mc 200 &
        loading_animation $!
        echo "Fuzzing completed. Results saved in fuzzing_output.txt."
    fi
}

# Function for Vulnerability Scanning
vulnerability_scanning() {
    echo -n "Enter the target URL or IP for vulnerability scanning (e.g., http://example.com): "
    read target
    if [ -z "$target" ]; then
        echo "Error: No target provided."
    else
        echo "Running Vulnerability Scanning using Nikto..."
        nikto -h "$target" -o vulnerability_scan_output.txt &
        loading_animation $!
        echo "Vulnerability scanning completed. Results saved in vulnerability_scan_output.txt."
    fi
}

# Function for Digital Forensics and Incident Response
digital_forensics() {
    echo "Running Digital Forensics using Volatility for memory analysis..."
    echo -n "Enter the path to the memory dump file (e.g., /path/to/memory.dmp): "
    read memory_dump
    if [ -z "$memory_dump" ]; then
        echo "Error: No memory dump file provided."
    else
        volatility -f "$memory_dump" --profile=Win7SP1x64 pslist > memory_analysis_output.txt &
        loading_animation $!
        echo "Memory analysis completed. Results saved in memory_analysis_output.txt."
    fi
}

# Function for Automated Data Collection
automated_data_collection() {
    echo "Running Automated Data Collection using OSQuery..."
    osqueryi "SELECT * FROM processes;" > data_collection_output.txt &
    loading_animation $!
    echo "Data collection completed. Results saved in data_collection_output.txt."
}

# Function for Anomaly Detection
anomaly_detection() {
    echo "Running Anomaly Detection using Snort..."
    echo -n "Enter the path to the pcap file (e.g., /path/to/traffic.pcap): "
    read pcap_file
    if [ -z "$pcap_file" ]; then
        echo "Error: No pcap file provided."
    else
        snort -r "$pcap_file" -c /etc/snort/snort.conf -A console > anomaly_detection_output.txt &
        loading_animation $!
        echo "Anomaly detection completed. Results saved in anomaly_detection_output.txt."
    fi
}

# Function to display goodbye message with animation
goodbye_message() {
    local colors=(31 32 33 34 35 36)
    echo -n "Goodbye! "

    for i in {0..10}; do
        echo -ne "\e[${colors[i % ${#colors[@]}]}m.\e[0m"
        sleep 0.5
    done
    echo
}

# Main script logic
display_logo  # Display the logo at the start

while true; do
    display_menu
    read choice

    case $choice in
        1) subdomain_enumeration ;;
        2) sub_ip_scanning ;;
        3) fuzzing ;;
        4) vulnerability_scanning ;;
        5) digital_forensics ;;
        6) automated_data_collection ;;
        7) anomaly_detection ;;
        8) goodbye_message ; exit ;;
        *) echo "Invalid option. Please select a number between 1 and 8." ;;
    esac
done