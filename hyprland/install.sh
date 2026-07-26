#!/bin/bash
set -e

DOTFILES="${DOTFILES:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$DOTFILES/scripts/lib.sh"

echo "Installing Hyprland config..."

mkdir -p "$HOME/.config/hypr/config"

link_file "$DOTFILES/hyprland/hyprland.lua"    "$HOME/.config/hypr/hyprland.lua"
link_file "$DOTFILES/hyprland/xdph.conf"       "$HOME/.config/hypr/xdph.conf"

for f in "$DOTFILES/hyprland/config/"*.lua; do
  link_file "$f" "$HOME/.config/hypr/config/$(basename "$f")"
done

echo "Hyprland config installed."
