#!/bin/bash
set -e

[ -z "${os:-}" ] && os="$(uname -s)"
if ! type link_file &>/dev/null; then
  lib="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/scripts/lib.sh"
  [ -f "$lib" ] || { echo "Missing $lib" >&2; exit 1; }
  source "$lib"
fi

echo "=== JankyBorders ==="

if [ "$os" != "Darwin" ]; then
  echo "  skipping — macOS only"
  return 0 2>/dev/null || exit 0
fi

if ! type borders &>/dev/null; then
  echo "  installing borders via brew..."
  brew install felixkratz/formulae/borders
fi

link_file "$DOTFILES/jankyborders/bordersrc" "$HOME/.config/borders/bordersrc"

echo "  starting borders service..."
brew services start felixkratz/formulae/borders 2>/dev/null || brew services restart felixkratz/formulae/borders
