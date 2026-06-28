#!/bin/bash
set -e

[ -z "${os:-}" ] && os="$(uname -s)"
if ! type link_file &>/dev/null; then
  lib="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/scripts/lib.sh"
  [ -f "$lib" ] || { echo "Missing $lib" >&2; exit 1; }
  source "$lib"
fi

echo "=== Ghostty ==="

if [ "$os" = "Darwin" ]; then
  link_file "$DOTFILES/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
else
  link_file "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"
fi

link_file "$DOTFILES/scripts/ghostty-init" "$HOME/.local/bin/ghostty-init"
