#!/bin/bash
set -e

DOTFILES="${DOTFILES:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
source "$DOTFILES/scripts/lib.sh"

echo ":: Installing Hyprland ecosystem"

# Detect distro and set package manager
if command -v pacman &>/dev/null; then
  PM="pacman"
  INSTALL_CMD="sudo pacman -S --needed --noconfirm"
  AUR_HELPER=""
  if command -v yay &>/dev/null; then
    AUR_HELPER="yay"
  elif command -v paru &>/dev/null; then
    AUR_HELPER="paru"
  fi
else
  echo "Unsupported distro. Only Arch-based distros are supported."
  exit 1
fi

# Install packages
echo ":: Installing packages..."
$INSTALL_CMD \
  hyprland \
  hyprlock \
  hypridle \
  hyprpaper \
  hyprsunset \
  hyprpicker \
  waybar \
  rofi \
  swaync \
  grim \
  slurp \
  wl-clipboard \
  jq \
  brightnessctl \
  playerctl \
  networkmanager \
  pavucontrol \
  pipewire \
  pipewire-pulse \
  wireplumber \
  figlet \
  tesseract \
  tesseract-data-eng \
  imagemagick \
  noto-fonts \
  ttf-jetbrains-mono-nerd \
  ttf-firacode-nerd \
  qt6ct \
  polkit-gnome \
  xdg-desktop-portal-hyprland \
  xdg-desktop-portal-gtk \
  --noconfirm 2>/dev/null || true

# Install AUR packages if helper is available
if [[ -n "$AUR_HELPER" ]]; then
  echo ":: Installing AUR packages (this may take a few minutes)..."
  $AUR_HELPER -S --needed --noconfirm \
    bibata-cursor-theme-bin 2>/dev/null || \
    $AUR_HELPER -S --needed --noconfirm bibata-cursor-theme 2>/dev/null || true
  $AUR_HELPER -S --needed --noconfirm \
    tela-circle-dracula-theme \
    grimblast-git 2>/dev/null || true
fi

echo ":: Setting up Hyprland config"

HYPR_DIR="$HOME/.config/hypr"

# If hypr dir is a symlink, remove it so we can create our own
if [ -L "$HYPR_DIR" ]; then
  echo "  removing existing symlink: $HYPR_DIR"
  rm "$HYPR_DIR"
fi
mkdir -p "$HYPR_DIR"

# Symlink main hyprland.conf
link_file "$DOTFILES/hyprland/hyprland.conf" "$HYPR_DIR/hyprland.conf"

# Symlink ml4w-style hypr config files
for f in "$DOTFILES"/hyprland/*.conf "$DOTFILES"/hyprland/*.lua; do
  [ -f "$f" ] || continue
  base=$(basename "$f")
  link_file "$f" "$HYPR_DIR/$base"
done

# Symlink conf/ subdirectories
for dir in conf; do
  if [ -d "$DOTFILES/hyprland/$dir" ]; then
    for f in "$DOTFILES/hyprland/$dir"/*; do
      [ -e "$f" ] || continue
      base=$(basename "$f")
      mkdir -p "$HYPR_DIR/$dir"
      if [ -d "$f" ]; then
        mkdir -p "$HYPR_DIR/$dir/$base"
        for sf in "$f"/*; do
          [ -f "$sf" ] || continue
          sbase=$(basename "$sf")
          link_file "$sf" "$HYPR_DIR/$dir/$base/$sbase"
        done
      else
        link_file "$f" "$HYPR_DIR/$dir/$base"
      fi
    done
  fi
done

# Symlink assets
mkdir -p "$HYPR_DIR/assets"
link_file "$DOTFILES/hyprland/assets/blank.png" "$HYPR_DIR/assets/blank.png"

# Symlink scripts
mkdir -p "$HYPR_DIR/scripts"
for f in "$DOTFILES/hyprland/scripts"/*.sh; do
  [ -f "$f" ] || continue
  base=$(basename "$f")
  link_file "$f" "$HYPR_DIR/scripts/$base"
  chmod +x "$HYPR_DIR/scripts/$base"
done

echo ":: Hyprland config installed"
