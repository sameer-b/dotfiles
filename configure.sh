#!/bin/bash
set -e

source "$(cd "$(dirname "$0")" && pwd)/scripts/lib.sh"

echo "Dotfiles: $DOTFILES"
echo "Backup:   $BACKUP_DIR"
echo ""

source "$DOTFILES/ghostty/install.sh"
source "$DOTFILES/fastfetch/install.sh"
source "$DOTFILES/omniwm/install.sh"

echo ""
echo "Done. Backups saved to $BACKUP_DIR"
