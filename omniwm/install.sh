[ "${BASH_SOURCE[0]}" = "$0" ] && echo "source this script, don't run it directly" >&2 && exit 1
type link_file &>/dev/null || { echo "  source scripts/lib.sh first" >&2; return 1; }

echo "=== OmniWM ==="

if [ "$os" != "Darwin" ]; then
  echo "  skipping: macOS only"
  return
fi

link_file "$DOTFILES/omniwm/settings.toml" "$HOME/.config/omniwm/settings.toml"
