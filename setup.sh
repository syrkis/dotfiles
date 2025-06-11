#!/usr/bin/env bash

# Dotfiles setup script
# Run this script to set up symlinks to your dotfiles

set -e  # Exit on any error

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

echo "🔧 Setting up dotfiles from $DOTFILES_DIR"

# Function to backup and remove existing files/links
backup_and_remove() {
    local target="$1"
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "  📦 Backing up existing $target"
        mkdir -p "$(dirname "$BACKUP_DIR/$target")"
        mv "$target" "$BACKUP_DIR/$(basename "$target")"
    fi
}

# Function to create symlink
create_link() {
    local source="$1"
    local target="$2"

    if [ ! -e "$source" ]; then
        echo "  ⚠️  Warning: Source $source doesn't exist, skipping"
        return
    fi

    echo "  🔗 Linking $target -> $source"
    mkdir -p "$(dirname "$target")"
    ln -sf "$source" "$target"
}

echo ""
echo "📋 Configuring applications..."

# Zed editor
if [ -d "$DOTFILES_DIR/config/zed" ]; then
    echo "⚡ Setting up Zed..."
    backup_and_remove "$HOME/.config/zed/settings.json"
    backup_and_remove "$HOME/.config/zed/themes"

    create_link "$DOTFILES_DIR/config/zed/settings.json" "$HOME/.config/zed/settings.json"
    create_link "$DOTFILES_DIR/config/zed/themes" "$HOME/.config/zed/themes"
fi

# Neovim
if [ -d "$DOTFILES_DIR/config/nvim" ]; then
    echo "📝 Setting up Neovim..."
    backup_and_remove "$HOME/.config/nvim"
    create_link "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"
fi

# Add more configurations here as needed
# Example:
# if [ -f "$DOTFILES_DIR/.tmux.conf" ]; then
#     echo "🖥️  Setting up tmux..."
#     backup_and_remove "$HOME/.tmux.conf"
#     create_link "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
# fi

echo ""
if [ -d "$BACKUP_DIR" ]; then
    echo "✅ Setup complete! Old files backed up to: $BACKUP_DIR"
else
    echo "✅ Setup complete! No existing files needed backup."
fi

echo ""
echo "📝 To make changes:"
echo "   Edit files in: $DOTFILES_DIR"
echo "   Changes will be reflected immediately in your configs"
echo ""
echo "🗑️  To uninstall:"
echo "   rm ~/.config/zed/settings.json ~/.config/zed/themes"
echo "   rm ~/.config/nvim"
echo "   # Then restore from backup if needed"
