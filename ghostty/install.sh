[ "${BASH_SOURCE[0]}" = "$0" ] && echo "source this script, don't run it directly" >&2 && exit 1

echo "=== Ghostty ==="

if [ "$os" = "Darwin" ]; then
  link_file "$DOTFILES/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
else
  link_file "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"
fi

link_file "$DOTFILES/scripts/ghostty-init" "$HOME/.local/bin/ghostty-init"
