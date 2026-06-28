#!/bin/bash
set -e

source "$(cd "$(dirname "$0")" && pwd)/scripts/lib.sh"

echo "Dotfiles: $DOTFILES"
echo "Backup:   $BACKUP_DIR"
echo ""

source "$DOTFILES/scripts/install-ghostty.sh"
source "$DOTFILES/scripts/install-fastfetch.sh"
source "$DOTFILES/scripts/install-omniwm.sh"

echo ""
echo "Done. Backups saved to $BACKUP_DIR"
