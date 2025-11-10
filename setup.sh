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

# Helix
if [ -d "$DOTFILES_DIR/config/helix" ]; then
    echo "📝 Setting up Helix..."
    backup_and_remove "$HOME/.config/helix"
    create_link "$DOTFILES_DIR/config/helix" "$HOME/.config/helix"
fi

# zellij
if [ -d "$DOTFILES_DIR/config/zellij" ]; then
    echo "📝 Setting up zellij..."
    backup_and_remove "$HOME/.config/zellij"
    create_link "$DOTFILES_DIR/config/zellij" "$HOME/.config/zellij"
fi

# Ghostty terminal
if [ -d "$DOTFILES_DIR/config/ghostty" ]; then
    echo "👻 Setting up Ghostty..."
    backup_and_remove "$HOME/.config/ghostty"
    create_link "$DOTFILES_DIR/config/ghostty" "$HOME/.config/ghostty"
fi

# Fish shell
if [ -d "$DOTFILES_DIR/config/fish" ]; then
    echo "🐟 Setting up Fish shell..."
    backup_and_remove "$HOME/.config/fish"
    create_link "$DOTFILES_DIR/config/fish" "$HOME/.config/fish"
fi

# Starship prompt
if [ -f "$DOTFILES_DIR/config/starship.toml" ]; then
    echo "🚀 Setting up Starship prompt..."
    backup_and_remove "$HOME/.config/starship.toml"
    create_link "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml"
fi

# Epy ebook reader
if [ -d "$DOTFILES_DIR/config/epy" ]; then
    echo "📚 Setting up Epy ebook reader..."
    backup_and_remove "$HOME/.config/epy"
    create_link "$DOTFILES_DIR/config/epy" "$HOME/.config/epy"
fi

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
echo "   rm ~/.config/ghostty"
echo "   rm ~/.config/fish"
echo "   rm ~/.config/starship.toml"
echo "   rm ~/.config/epy"
echo "   # Then restore from backup if needed"

# Skim PDF viewer
if command -v duti >/dev/null 2>&1; then
    echo "📄 Setting up Skim as default PDF reader..."
    duti -s net.sourceforge.skim-app.skim pdf all
    duti -s com.readest.readest epub all
    echo "  ✅ Skim set as default PDF reader"
else
    echo "  ⚠️  Warning: duti not found, skipping Skim PDF setup"
fi
