#!/bin/bash
set -e

DOTFILES="${DOTFILES:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
source "$DOTFILES/scripts/lib.sh"

echo ":: Installing Waybar"

# Detect distro and set package manager
if command -v pacman &>/dev/null; then
  INSTALL_CMD="sudo pacman -S --needed --noconfirm"
else
  echo "Unsupported distro. Only Arch-based distros are supported."
  exit 1
fi

# Install packages
$INSTALL_CMD waybar --noconfirm 2>/dev/null || true

echo ":: Setting up Waybar config"

WAYBAR_DIR="$HOME/.config/waybar"

# Remove existing symlink or file to avoid conflicts
if [ -L "$WAYBAR_DIR" ] || [ -f "$WAYBAR_DIR" ]; then
  rm -f "$WAYBAR_DIR"
fi

mkdir -p "$WAYBAR_DIR/scripts"

# Symlink config files
link_file "$DOTFILES/waybar/config.jsonc" "$WAYBAR_DIR/config.jsonc"
link_file "$DOTFILES/waybar/style.css" "$WAYBAR_DIR/style.css"

# Symlink scripts
for f in "$DOTFILES/waybar/scripts"/*.sh; do
  [ -f "$f" ] || continue
  base=$(basename "$f")
  link_file "$f" "$WAYBAR_DIR/scripts/$base"
  chmod +x "$WAYBAR_DIR/scripts/$base"
done

echo ":: Waybar config installed. Restart waybar or run: killall waybar && waybar"
