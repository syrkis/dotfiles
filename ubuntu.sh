#!/bin/bash
# ubuntu.sh - Script to set up a new Ubuntu installation with custom configurations and software

echo "Updating and upgrading system packages..."
if ! grep -q "^deb .*ppa:fish-shell/release-3" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo apt-add-repository ppa:fish-shell/release-3 -y
fi
sudo apt update && sudo apt upgrade -y

echo "Installing essential packages..."
# Checks if each package is installed before attempting to install
for package in git fish vim neovim pass curl wget gpg tmux htop build-essential ca-certificates gnupg-agent software-properties-common fonts-firacode; do
    if ! dpkg -s "$package" >/dev/null 2>&1; then
        sudo apt install -y "$package"
    else
        echo "$package is already installed."
    fi
done

echo "Configuring Git..."
git config --global user.name "$(read -p 'Enter your Git name: ' gitusername; echo $gitusername)"
git config --global user.email "$(read -p 'Enter your Git email: ' gitemail; echo $gitemail)"

echo "Installing Snap applications..."
declare -a snapapps=("slack" "discord" "obsidian" "code" "languagetool" "logseq" "alacritty" "zotero-snap")
for app in "${snapapps[@]}"; do
    if ! snap list "$app" >/dev/null 2>&1; then
        sudo snap install --classic "$app"
    else
        echo "$app is already installed."
    fi
done

# Change default shell to Fish
if [ "$(basename $SHELL)" != "fish" ]; then
    echo "Changing default shell to Fish..."
    chsh -s "$(which fish)"
fi

# SSH Key Generation
SSH_DIR="$HOME/.ssh"
if [ ! -d "$SSH_DIR" ] || [ -z "$(ls -A $SSH_DIR)" ]; then
    echo "No SSH keys found. Generating a new SSH key..."
    ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
else
    echo "SSH keys already exist."
fi

echo "Your public SSH key:"
cat "$SSH_DIR/id_rsa.pub"
echo "Add this key to your GitHub account."
echo "Press Enter once you've added the key to GitHub..."
read -p ""

# Clone dot files repo
DOTFILES_DIR="$HOME/code/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Cloning dotfiles repo..."
    mkdir -p ~/code
    git clone git@github.com:syrkis/dotfiles.git "$DOTFILES_DIR"
else
    echo "Dotfiles repo already cloned."
fi

# Symlink dotfiles
echo "Symlinking dotfiles..."
ln -sfn "$DOTFILES_DIR/config/fish" ~/.config/fish
ln -sfn "$DOTFILES_DIR/config/nvim" ~/.config/nvim
ln -sfn "$DOTFILES_DIR/config/tmux" ~/.config/tmux

# Setup pass-cli (password manager)
echo "Setting up pass..."
if [ ! -d "$HOME/.password-store" ]; then
    echo "put public.key and private.key in ~/Desktop (will be deleted after setup)"
    read -p "Press Enter once you've done this..."
    if [ ! -f ~/Desktop/public.key ] || [ ! -f ~/Desktop/private.key ]; then
        echo "public.key and/or private.key not found in ~/Desktop. exiting pass setup, and continuing with setup..."
        exit 1
    fi
    git clone git@github.com/syrkis/pass.git "$HOME/.password-store"
    gpg --import ~/Desktop/public.key
    gpg --allow-secret-key-import --import ~/Desktop/private.key
    rm ~/Desktop/public.key ~/Desktop/private.key
else
    echo "pass is already set up."
fi

echo "Setup complete!"
