#!/bin/bash

# Redirect all output to the specified log file
exec > >(tee -a /opt/logs/script_logs.log)
exec 2>&1

# Echo each step with date & time stamp
log() {
  echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

log "Script started."

# Step 1: Download OpenJDK 1.8
log "Step 1: Downloading OpenJDK 1.8..."
sudo yum install java-1.8.0-openjdk -y

# Step 2: Install Java
log "Step 2: Installing Java..."
sudo yum install java-1.8.0-openjdk-devel -y

# Step 3: Add Java executable path to PATH and .bashrc
log "Step 3: Adding Java executable path to PATH and .bashrc..."
echo "export PATH=\$PATH:/usr/lib/jvm/java-1.8.0-openjdk/bin" >> ~/.bashrc
export PATH=$PATH:/usr/lib/jvm/java-1.8.0-openjdk/bin

# Step 4: Ensure the terminal can echo each step with date & time stamp
log "Step 4: Ensuring the terminal can echo each step with date & time stamp..."

# Source the .bashrc to make the changes take effect in the current session
source ~/.bashrc

log "Script completed."
