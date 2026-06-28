[ "${BASH_SOURCE[0]}" = "$0" ] && echo "source this script, don't run it directly" >&2 && exit 1

echo "=== Fastfetch ==="

mkdir -p "$HOME/.config/fastfetch"

[ -L "$HOME/.config/fastfetch/config.jsonc" ] && rm "$HOME/.config/fastfetch/config.jsonc"
cp "$DOTFILES/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
sed_i "s|PLACEHOLDER_LOGO_PATH|$HOME/.config/fastfetch/cats/cat2.png|" "$HOME/.config/fastfetch/config.jsonc"
echo "  wrote config to $HOME/.config/fastfetch/config.jsonc"

mkdir -p "$HOME/.config/fastfetch/cats"
shopt -s nullglob
images=("$DOTFILES/assets/cats/"*.png)
shopt -u nullglob
if [ ${#images[@]} -gt 0 ]; then
  cp "${images[@]}" "$HOME/.config/fastfetch/cats/"
  echo "  copied images to $HOME/.config/fastfetch/cats/"
fi

link_file "$DOTFILES/scripts/catfetch" "$HOME/.local/bin/catfetch"

if [ ! -e "$HOME/Pictures/cats" ] || [ -L "$HOME/Pictures/cats" ]; then
  rm -f "$HOME/Pictures/cats"
  link_file "$DOTFILES/assets/cats" "$HOME/Pictures/cats"
fi
