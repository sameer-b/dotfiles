#!/bin/bash
set -e

[ -z "${os:-}" ] && os="$(uname -s)"
if ! type link_file &>/dev/null; then
  lib="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/scripts/lib.sh"
  [ -f "$lib" ] || { echo "Missing $lib" >&2; exit 1; }
  source "$lib"
fi

echo "=== AeroSpace ==="

if [ "$os" = "Darwin" ]; then
  if ! [ -d /Applications/AeroSpace.app ]; then
    echo "  installing aerospace via brew..."
    brew install --cask nikitabobko/tap/aerospace
  fi

  link_file "$DOTFILES/aero space/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"
fi
