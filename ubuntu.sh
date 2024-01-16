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
    git clone git@github.com:syrkis/pass.git "$HOME/.password-store"
    gpg --import ~/Desktop/public.key
    gpg --allow-secret-key-import --import ~/Desktop/private.key
    # rm ~/Desktop/public.key ~/Desktop/private.key
else
    echo "pass is already set up."
fi



# Install pyenv dependencies
echo "Installing pyenv dependencies..."
PYENV_DEPS="libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git"
for dep in $PYENV_DEPS; do
    if ! dpkg -s "$dep" >/dev/null 2>&1; then
        sudo apt install -y "$dep"
    else
        echo "$dep is already installed."
    fi
done

# install eza
if ! command -v eza >/dev/null 2>&1; then
    echo "Installing eza..."
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
else
    echo "eza is already installed."
fi

# Install nvm plugin for fish
echo "Installing vim-plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install pyenv
echo "Installing pyenv..."
if [ ! -d "$HOME/.pyenv" ]; then
    curl https://pyenv.run | bash
    set -Ux PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
else
    echo "pyenv is already installed."
fi

# Install starship
echo "Installing starship..."
if ! command -v starship >/dev/null 2>&1; then
    curl -fsSL https://starship.rs/install.sh | sh
    echo 'eval "$(starship init fish)"' >> ~/.config/fish/config.fish
else
    echo "starship is already installed."
fi

echo "Setup complete!"
