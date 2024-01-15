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
read -p "Enter your Git username: " gitusername
git config --global user.name "$gitusername"
read -p "Enter your Git email: " gitemail
git config --global user.email "$gitemail"

echo "Installing Snap applications..."
# Installs applications using Snap (make list of snap apps to install, and then loop through)
declare -a snapapps=("slack" "discord" "obsidian" "code")
for app in "${snapapps[@]}"
do
    sudo snap install --classic $app
done

# Change default shell to Fish
echo "Changing default shell to Fish..."
chsh -s $(which fish)

echo "Setup complete!"
