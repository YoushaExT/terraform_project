#!/bin/bash

# Update package index
sudo apt update

# -- NGINX --

# Install Nginx
sudo apt install -y nginx

# Start Nginx service
sudo systemctl start nginx

# Enable Nginx service to start on boot
sudo systemctl enable nginx

# -- NODE 20 --

# Update registry for node 20
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -

# Install node 20
sudo apt-get install nodejs -y

# -- DOCKER --

sudo apt install docker.io -y