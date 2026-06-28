#!/bin/bash
set -e

[ -z "${os:-}" ] && os="$(uname -s)"
[ -z "${DOTFILES:-}" ] && DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== SketchyBar ==="

if [ "$os" != "Darwin" ]; then
  echo "  skipping: macOS only"
  [ "${BASH_SOURCE[0]}" = "$0" ] && exit 0 || return 0
fi

brew tap FelixKratz/formulae 2>/dev/null || true
brew trust --quiet FelixKratz/formulae 2>/dev/null || true
brew install sketchybar 2>/dev/null || true
brew install malpern/tap/sketchybar-toggle 2>/dev/null || true
