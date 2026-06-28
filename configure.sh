#!/bin/bash
set -e

DOTFILES="${DOTFILES:-$(cd "$(dirname "$0")" && pwd)}"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

echo "Dotfiles: $DOTFILES"
echo "Backup:   $BACKUP_DIR"
echo ""

link_file() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -f "$dst" ] && [ ! -L "$dst" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "$BACKUP_DIR/"
    echo "  backed up: $dst"
  fi
  ln -sf "$src" "$dst"
  echo "  linked:    $dst <- $src"
}

os="$(uname -s)"

# Ghostty
if [ "$os" = "Darwin" ]; then
  link_file "$DOTFILES/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
else
  link_file "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"
fi

sed_i() {
  if [ "$(uname -s)" = "Darwin" ]; then
    sed -i '' "$@"
  else
    sed -i "$@"
  fi
}

# Fastfetch
link_file "$DOTFILES/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"

# Copy cat images to fastfetch config dir and update logo source path
mkdir -p "$HOME/.config/fastfetch/cats"
cp "$DOTFILES/assets/cats/"*.png "$HOME/.config/fastfetch/cats/"
sed_i "s|PLACEHOLDER_LOGO_PATH|$HOME/.config/fastfetch/cats/cat2.png|" "$DOTFILES/fastfetch/config.jsonc"
echo "  copied images to $HOME/.config/fastfetch/cats/"
echo "  updated logo source in $DOTFILES/fastfetch/config.jsonc"

# Scripts
link_file "$DOTFILES/scripts/ghostty-init" "$HOME/.local/bin/ghostty-init"
link_file "$DOTFILES/scripts/catfetch" "$HOME/.local/bin/catfetch"

# Cat images directory (so ~/Pictures/cats resolves for backwards compat)
if [ ! -e "$HOME/Pictures/cats" ] || [ -L "$HOME/Pictures/cats" ]; then
  rm -f "$HOME/Pictures/cats"
  link_file "$DOTFILES/assets/cats" "$HOME/Pictures/cats"
fi

echo ""
echo "Done. Backups saved to $BACKUP_DIR"
