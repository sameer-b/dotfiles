echo "=== Fastfetch ==="

mkdir -p "$HOME/.config/fastfetch"

[ -L "$HOME/.config/fastfetch/config.jsonc" ] && rm "$HOME/.config/fastfetch/config.jsonc"
cp "$DOTFILES/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
sed_i "s|PLACEHOLDER_LOGO_PATH|$HOME/.config/fastfetch/cats/cat2.png|" "$HOME/.config/fastfetch/config.jsonc"
echo "  wrote config to $HOME/.config/fastfetch/config.jsonc"

mkdir -p "$HOME/.config/fastfetch/cats"
cp "$DOTFILES/assets/cats/"*.png "$HOME/.config/fastfetch/cats/"
echo "  copied images to $HOME/.config/fastfetch/cats/"

link_file "$DOTFILES/scripts/catfetch" "$HOME/.local/bin/catfetch"

if [ ! -e "$HOME/Pictures/cats" ] || [ -L "$HOME/Pictures/cats" ]; then
  rm -f "$HOME/Pictures/cats"
  link_file "$DOTFILES/assets/cats" "$HOME/Pictures/cats"
fi
