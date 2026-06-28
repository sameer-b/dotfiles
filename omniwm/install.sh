#!/bin/bash
set -e

[ -z "${os:-}" ] && os="$(uname -s)"
if ! type link_file &>/dev/null; then
  lib="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/scripts/lib.sh"
  [ -f "$lib" ] || { echo "Missing $lib" >&2; exit 1; }
  source "$lib"
fi

echo "=== OmniWM ==="

if [ "$os" != "Darwin" ]; then
  echo "  skipping: macOS only"
  [ "${BASH_SOURCE[0]}" = "$0" ] && exit 0 || return 0
fi

link_file "$DOTFILES/omniwm/settings.toml" "$HOME/.config/omniwm/settings.toml"
