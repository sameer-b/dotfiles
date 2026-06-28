DOTFILES="${DOTFILES:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

os="$(uname -s)"

link_file() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -f "$dst" ] && [ ! -L "$dst" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "$BACKUP_DIR/"
    echo "  backed up: $dst"
  fi
  ln -sf "$src" "$dst"
  echo "  linked:    $dst <- $src"
}

sed_i() {
  if [ "$os" = "Darwin" ]; then
    sed -i '' "$@"
  else
    sed -i "$@"
  fi
}
