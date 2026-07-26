#!/bin/bash
set -e

DOTFILES="${DOTFILES:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
source "$DOTFILES/scripts/lib.sh"

echo ":: Installing Rofi"

# Detect distro and set package manager
if command -v pacman &>/dev/null; then
  INSTALL_CMD="sudo pacman -S --needed --noconfirm"
else
  echo "Unsupported distro. Only Arch-based distros are supported."
  exit 1
fi

# Install packages
$INSTALL_CMD rofi --noconfirm 2>/dev/null || true

echo ":: Setting up Rofi config"

ROFI_DIR="$HOME/.config/rofi"
mkdir -p "$ROFI_DIR"

# Symlink all .rasi files
for f in "$DOTFILES/rofi"/*.rasi; do
  [ -f "$f" ] || continue
  base=$(basename "$f")
  link_file "$f" "$ROFI_DIR/$base"
done

echo ":: Rofi config installed"
