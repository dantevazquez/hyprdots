#!/bin/bash
set -e
DOTS_DIR=$(pwd)
CONFIG_DIR="$HOME/.config"
PKGLIST="$DOTS_DIR/pkglist.txt"

echo "🚀 Starting Arch setup..."
echo "🛠️ Installing base-devel and git..."
sudo pacman -S --needed --noconfirm base-devel git

if ! command -v yay &>/dev/null; then
  echo "📦 'yay' not found. Installing from AUR..."
  TEMP_DIR=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git "$TEMP_DIR"
  cd "$TEMP_DIR"
  makepkg -si --noconfirm
  cd "$DOTS_DIR"
  rm -rf "$TEMP_DIR"
else
  echo "✅ 'yay' is already installed."
fi

if [ -f "$PKGLIST" ]; then
  echo "📦 Installing packages from pkglist.txt..."
  yay -S --needed --noconfirm - <"$PKGLIST"
fi

configs=("alacritty" "btop" "hypr" "hyprshell" "mako" "swayosd" "waybar")
echo "🔗 Symlinking .config folders..."
mkdir -p "$CONFIG_DIR"
for folder in "${configs[@]}"; do
  if [ -d "$DOTS_DIR/$folder" ]; then
    rm -rf "$CONFIG_DIR/$folder"
    ln -s "$DOTS_DIR/$folder" "$CONFIG_DIR/$folder"
    echo "  - Linked $folder"
  fi
done

echo "🏠 Linking home dotfiles..."
ln -sf "$DOTS_DIR/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTS_DIR/.tmux.conf" "$HOME/.tmux.conf"

echo "✨ Installation complete! You may need to log out/in for changes to take effect."
