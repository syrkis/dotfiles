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
read -p "Enter your Git name: " gitusername
git config --global user.name "$gitusername"
read -p "Enter your Git email: " gitemail
git config --global user.email "$gitemail"

echo "Installing Snap applications..."
# Installs applications using Snap (make list of snap apps to install, and then loop through)
declare -a snapapps=("slack" "discord" "obsidian" "code" "languagetool" "logseq" "alacritty" "zotero-snap")
for app in "${snapapps[@]}"
do
    sudo snap install --classic $app
done

# Change default shell to Fish
echo "Changing default shell to Fish..."
chsh -s $(which fish)

# Give credentials to new machine
echo "Checking for existing SSH keys..."
SSH_DIR="$HOME/.ssh"
if [ ! -d "$SSH_DIR" ] || [ -z "$(ls -A $SSH_DIR)" ]; then
    echo "No SSH keys found. Generating a new SSH key..."
    # Replace 'your_email@example.com' with your email
    ssh-keygen
else
    echo "SSH keys already exist."
fi

echo "Your public SSH key:"
cat $SSH_DIR/id_rsa.pub

echo "Add this key to your GitHub account in some way."
echo "Press Enter once you've added the key to GitHub..."
read -p ""

echo "Setup complete!"
