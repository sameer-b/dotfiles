echo "=== OmniWM ==="

if [ "$os" != "Darwin" ]; then
  echo "  skipping: macOS only"
  return
fi

link_file "$DOTFILES/omniwm/settings.toml" "$HOME/.config/omniwm/settings.toml"
