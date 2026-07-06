#!/bin/bash
set -e

[ -z "${os:-}" ] && os="$(uname -s)"
if ! type link_file &>/dev/null; then
  lib="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/scripts/lib.sh"
  [ -f "$lib" ] || { echo "Missing $lib" >&2; exit 1; }
  source "$lib"
fi

echo "=== Neovim ==="

if ! type nvim &>/dev/null; then
  if [ "$os" = "Darwin" ]; then
    echo "  installing neovim via brew..."
    brew install -q neovim
  else
    echo "  installing neovim via pacman..."
    sudo pacman -S --noconfirm neovim
  fi
fi

if [ ! -f "$HOME/.config/nvim/init.lua" ]; then
  echo "  cloning NvChad starter template..."
  git clone https://github.com/NvChad/starter "$HOME/.config/nvim"
fi

echo "  linking custom config..."
rm -rf "$HOME/.config/nvim/lua/custom"
link_file "$DOTFILES/nvim/lua/custom" "$HOME/.config/nvim/lua/custom"
