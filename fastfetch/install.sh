#!/bin/bash
set -e

[ -z "${os:-}" ] && os="$(uname -s)"
if ! type link_file &>/dev/null; then
  lib="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/scripts/lib.sh"
  [ -f "$lib" ] || { echo "Missing $lib" >&2; exit 1; }
  source "$lib"
fi

echo "=== Fastfetch ==="

mkdir -p "$HOME/.config/fastfetch"

[ -L "$HOME/.config/fastfetch/config.jsonc" ] && rm "$HOME/.config/fastfetch/config.jsonc"
cp "$DOTFILES/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
sed_i "s|PLACEHOLDER_LOGO_PATH|$HOME/.config/fastfetch/cats/cat2.png|" "$HOME/.config/fastfetch/config.jsonc"
echo "  wrote config to $HOME/.config/fastfetch/config.jsonc"

mkdir -p "$HOME/.config/fastfetch/cats"
shopt -s nullglob
images=("$DOTFILES/assets/cats/"*.png)
shopt -u nullglob
if [ ${#images[@]} -gt 0 ]; then
  cp "${images[@]}" "$HOME/.config/fastfetch/cats/"
  echo "  copied images to $HOME/.config/fastfetch/cats/"
fi

link_file "$DOTFILES/scripts/catfetch" "$HOME/.local/bin/catfetch"

if [ ! -e "$HOME/Pictures/cats" ] || [ -L "$HOME/Pictures/cats" ]; then
  rm -f "$HOME/Pictures/cats"
  link_file "$DOTFILES/assets/cats" "$HOME/Pictures/cats"
fi
