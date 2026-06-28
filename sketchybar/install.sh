#!/bin/bash
set -e

[ -z "${os:-}" ] && os="$(uname -s)"
[ -z "${DOTFILES:-}" ] && DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if ! type link_file &>/dev/null; then
  lib="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/scripts/lib.sh"
  [ -f "$lib" ] || { echo "Missing $lib" >&2; exit 1; }
  source "$lib"
fi

echo "=== SketchyBar ==="

if [ "$os" != "Darwin" ]; then
  echo "  skipping: macOS only"
  [ "${BASH_SOURCE[0]}" = "$0" ] && exit 0 || return 0
fi

# Install packages
brew tap FelixKratz/formulae 2>/dev/null || true
brew trust --quiet FelixKratz/formulae 2>/dev/null || true
brew install sketchybar 2>/dev/null || true
brew install malpern/tap/sketchybar-toggle 2>/dev/null || true
brew install lua 2>/dev/null || true
brew install --cask sf-symbols 2>/dev/null || true

# Install SbarLua (Lua API bindings for sketchybar)
if [ ! -f "$HOME/.local/share/sketchybar_lua/sketchybar.so" ]; then
  echo "  installing SbarLua..."
  git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua 2>/dev/null || true
  (cd /tmp/SbarLua && make install && rm -rf /tmp/SbarLua) 2>/dev/null || true
fi

# Install sketchybar-app-font for app icons
if [ ! -f "$HOME/Library/Fonts/sketchybar-app-font.ttf" ]; then
  echo "  installing sketchybar-app-font..."
  curl -sL https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.5/sketchybar-app-font.ttf \
    -o "$HOME/Library/Fonts/sketchybar-app-font.ttf" 2>/dev/null || true
fi

# Deploy config — symlink every file in sketchybar/ except install.sh
echo "  deploying config..."
mkdir -p "$HOME/.config/sketchybar"

for entry in "$DOTFILES/sketchybar/"*; do
  name="$(basename "$entry")"
  [ "$name" = "install.sh" ] && continue
  if [ -d "$entry" ]; then
    # Symlink subdirectories (items/, helpers/)
    [ -L "$HOME/.config/sketchybar/$name" ] && rm "$HOME/.config/sketchybar/$name"
    [ ! -e "$HOME/.config/sketchybar/$name" ] && ln -sf "$entry" "$HOME/.config/sketchybar/$name"
  else
    link_file "$entry" "$HOME/.config/sketchybar/$name"
  fi
done

# Start sketchybar
echo "  starting sketchybar..."
brew services start FelixKratz/formulae/sketchybar 2>/dev/null || true
