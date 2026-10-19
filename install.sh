#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

echo "Installing packages..."
sudo pacman -S --needed --noconfirm fish kitty rofi waybar flameshot firefox swaybg

echo "Installing configs..."
mkdir -p "$CONFIG_DIR" "$BACKUP_DIR"

for dir in fish hypr kitty rofi waybar; do
    if [ -e "$CONFIG_DIR/$dir" ]; then
        echo "    Backing up existing $dir"
        mv "$CONFIG_DIR/$dir" "$BACKUP_DIR/"
    fi
    cp -r "$REPO_DIR/$dir" "$CONFIG_DIR/$dir"
done

echo "Copying wallpaper..."
mkdir -p "$HOME/Wallpapers"
cp "$REPO_DIR/wallpaper.png" "$HOME/Wallpapers/"

echo "Done. Old configs backed up to $BACKUP_DIR"
