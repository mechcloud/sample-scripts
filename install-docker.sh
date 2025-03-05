#!/bin/bash

# Update package index and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install required dependencies
apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index again
apt-get update

# Install Docker Engine, CLI, and Containerd
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Enable and start Docker service
systemctl enable docker
systemctl start docker

# Add ubuntu user to docker group (optional, for non-root access)
usermod -aG docker ubuntu

# Verify Docker is running
docker run hello-world

# Clean up
apt-get clean
rm -rf /var/lib/apt/lists/*
