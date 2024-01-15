#!/bin/bash
# ubuntu.sh - Script to set up a new Ubuntu installation with custom configurations and software

echo "Updating and upgrading system packages..."
sudo apt-add-repository ppa:fish-shell/release-3 -y
sudo apt update && sudo apt upgrade -y

echo "Installing essential packages..."
# Installs common tools and utilities
sudo apt install -y \
    git \
    fish \
    vim \
    pass \
    curl \
    wget \
    tmux \
    htop \
    build-essential \
    ca-certificates \
    gnupg-agent \
    software-properties-common \
    fonts-firacode

echo "Configuring Git..."
# Prompt for Git username and email, repeat if input is empty
while true; do
    read -p "Enter your Git global username: " gitusername
    if [ -n "$gitusername" ]; then
        git config --global user.name "$gitusername"
        break
    else
        echo "Username cannot be empty. Please enter a valid username."
    fi
done

while true; do
    read -p "Enter your Git global email: " gitemail
    if [ -n "$gitemail" ]; then
        git config --global user.email "$gitemail"
        break
    else
        echo "Email cannot be empty. Please enter a valid email."
    fi
done

echo "Installing Snap applications..."
# Installs applications using Snap
sudo snap install --classic code obsidian logseq

# Change default shell to Fish
chsh -s `which fish`

echo "Setup complete!"
