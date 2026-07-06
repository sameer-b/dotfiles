#!/bin/bash
set -e

lib="$(cd "$(dirname "$0")" && pwd)/scripts/lib.sh"
[ -f "$lib" ] || { echo "Missing $lib" >&2; exit 1; }
source "$lib"

echo "Dotfiles: $DOTFILES"
echo "Backup:   $BACKUP_DIR"
echo ""

source "$DOTFILES/ghostty/install.sh"
source "$DOTFILES/fastfetch/install.sh"
source "$DOTFILES/omniwm/install.sh"
source "$DOTFILES/sketchybar/install.sh"
source "$DOTFILES/jankyborders/install.sh"
source "$DOTFILES/nvim/install.sh"
source "$DOTFILES/aero space/install.sh"

echo ""
echo "Done. Backups saved to $BACKUP_DIR"
