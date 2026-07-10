# AGENTS.md — Dotfiles

## Overview

macOS-centric dotfiles for a tiling window manager setup with AeroSpace, Ghostty terminal, OmniWM, SketchyBar status bar, and fastfetch system info. The aesthetic is **Catppuccin Mocha + Hack Nerd Font Mono + transparency/blur + cat-themed fastfetch**.

**No shell rc files (`.zshrc`, `.bashrc`), no Git config, no editor configs live here.** This repo only manages the visual/WM layer.

---

## Project Structure

```
dotfiles/
├── configure.sh              # Master installer — sources each install.sh
├── AGENTS.md                 # This file
├── assets/cats/              # 4 cat PNG images (cat2.png, cat4.png–cat6.png)
├── assets/icons/             # SketchyBar widget PNG icons
├── aero space/
│   ├── aerospace.toml        # AeroSpace tiling WM config
│   └── install.sh
├── scripts/
│   ├── lib.sh                # Shared helpers: link_file(), sed_i()
│   ├── catfetch              # Wrapper: fastfetch + random cat logo
│   └── ghostty-init          # Ghostty launcher: catfetch then login shell
├── fastfetch/
│   ├── config.jsonc          # System info display config
│   └── install.sh
├── ghostty/
│   ├── config                # Ghostty terminal config
│   └── install.sh
├── jankyborders/
│   ├── bordersrc             # JankyBorders config (width, style, colors)
│   └── install.sh
├── nvim/
│   ├── init.lua              # Minimal Neovim config (lazy.nvim, LSP, Telescope)
│   └── install.sh
├── omniwm/
│   ├── settings.toml         # OmniWM tiling WM config (821 lines)
│   └── install.sh
└── sketchybar/
    ├── install.sh            # macOS: installs sketchybar + Lua dependencies
    ├── sketchybarrc          # Lua entry point
    ├── init.lua              # Main init + omniwmctl watcher
    ├── bar.lua               # Bar appearance (transparent, blur, margin)
    ├── default.lua           # Default item styles (font, colors, padding)
    ├── settings.lua          # Font family + padding constants
    ├── colors.lua            # Active SketchyBar colors
    ├── items/
    │   ├── init.lua          # Assembles left/right brackets
    │   ├── apple.lua         # Apple logo → System Settings
    │   ├── spaces.lua        # 9 workspace indicators with app icons
    │   ├── battery.lua       # Battery percentage + PNG icon (pmset)
    │   ├── cpu.lua           # CPU percentage + PNG icon
    │   ├── memory.lua        # Memory pressure + PNG icon
    │   └── calendar.lua      # Date and time
    └── helpers/
        └── spaces_helper.py  # Python: queries OmniWM for windows/icons
```

---

## Key Conventions

### Shell & Scripting
- **All install scripts are `#!/bin/bash`** with `set -e`
- **Scripts/helpers** installed to `~/.local/bin/`
- **Cross-platform helpers** in `scripts/lib.sh`:
  - `link_file src dst` — symlinks, backs up existing regular files to `~/.dotfiles-backup-<timestamp>/`
  - `sed_i` — wraps `sed -i` for macOS (`sed -i ''`) vs Linux compatibility
- **Bash nullglob** is used before globbing (set via `shopt -s nullglob` and reset after with `shopt -u nullglob`)

### Color Scheme: Catppuccin Mocha
SketchyBar keeps only the active colors it currently references in `sketchybar/colors.lua`:

| Name      | Hex       | Usage                    |
|-----------|-----------|--------------------------|
| subtle    | `#9399b2` | Subtle text              |
| text      | `#cdd6f4` | Primary text             |
| love      | `#f38ba8` | Pink (active underline)  |
| red       | `#ed8796` | Low battery warning      |
| green     | `#a6da95` |                          |
| blue      | `#8aadf4` |                          |
| yellow    | `#eed49f` |                          |
| orange    | `#f5a97f` | Medium battery warning   |
| transparent | `0x00000000` | Transparent backgrounds |
| bg1       | `0x00000000` | Bracket background (transparent) |
| popup     | `0xf0181926` | Popup background       |

In Lua: colors use `0xAARRGGBB` format.  
In Ghostty config: standard theme name `Catppuccin Mocha`.  
In OmniWM `settings.toml`: RGB floats (e.g., accent border = `1.0, 0.37, 0.99` ~ iris).

### Fonts
- **Primary**: `Hack Nerd Font Mono`
- **sketchybar-app-font** (TTF) for workspace app icons — installed via GitHub release
- **SF Symbols** (brew cask) — available but not directly referenced in current config
- Nerd Font icons are still used in fastfetch. SketchyBar uses PNG assets for Apple, CPU, memory, battery, and extracted app icons for workspaces.

### Transparency & Blur
- Ghostty: `background-opacity = 0.5`, `background-blur-radius = 30`, `unfocused-split-opacity = 0.7`
- SketchyBar bar: `blur_radius = 30`, `color = colors.transparent`
- OmniWM quake terminal: `opacity = 0.8`

---

## Component Details

### Ghostty (`ghostty/config`, 41 lines)
- Theme: Catppuccin Mocha
- Font: Hack Nerd Font Mono 15px with calt/liga/clig/dlig features
- Cursor: bar style with blink
- macOS: transparent titlebar, non-native fullscreen, window shadows, `macos-option-as-alt = true`
- `command = ~/.local/bin/ghostty-init` — runs fastfetch + cat on terminal start
- Selection colors: `#585b70` bg, `#cdd6f4` fg
- Cell adjustment: +2 height, -1 width
- Padding: 12x8 balanced

### OmniWM (`omniwm/settings.toml`, 821 lines)
- **Default layout**: Dwindle
- **5 workspaces**: 1-3 Dwindle, 4 Niri (3 columns), 5 Dwindle
- **Gaps**: inner 10px, outer top 50px (for menubar), other sides 5px
- **Borders**: 5px, accent (iris) color `RGB(1.0, 0.37, 0.99)`
- **Quake terminal**: Option+`, 50% width/height, 80% opacity, centered
- **Routing mode**: macOS
- **13 appRules** with min window sizes (Chrome, Safari, Zen, Firefox, Dia, Spotify, Discord, Ghostty, Outlook, Messages, Codex, Command Terminal, Zed)
- **Hotkeys**: Workspace switching (Option+1-9), move windows (Option+Shift+1-9), focus arrows (Option+arrows), focus previous (Option+Tab), monitor cycling (Control+Command+Tab), layout toggle (Option+Shift+L), overview (Option+Shift+O), column width (Option+Period/Comma), balance sizes (Option+Shift+B), command palette (Control+Option+Space), menu (Control+Option+M), toggle fullscreen (Option+Return)
- Gestures: 4-finger trackpad, Option+Shift scroll modifier
- StatusBar: shows app names + workspace names
- WorkspaceBar: **disabled** (`xOffset = -3000`), but configured with accent color

### SketchyBar (Lua configs)
- **Top bar**: transparent, blur 30, y-offset 8, margin 128 (notch aware)
- **Left bracket**: Apple PNG logo → 9 workspace indicators with app icons (pink underline on active) → spacer
- **Center**: 200px hidden spacer (notch filler)
- **Right brackets**: CPU → memory → battery → date/time
- **Brackets**: `bg1` (`0x00000000`, transparent), corner radius 16, height 28, border 0
- **Items**: Hack Nerd Font Mono, Bold 12-13pt
- **Event-driven**: `omniwmctl watch active-workspace,windows-changed` triggers `space_update` event
- **Battery**: updates every 120s, on power source change, on system wake; colors: red ≤15%, orange ≤25%
- **Calendar**: updates every minute on routine/forced/system_woke events
- **sketchybar-toggle** runs in background for hide/show

### spaces_helper.py (Python helper)
- Queries `omniwmctl query workspaces --current --format json` for active workspace
- Queries `omniwmctl query windows --fields app,workspace --format json` for all windows
- Extracts `.icns` icons using `sips` (macOS), caches as PNG to `~/.config/sketchybar/app-icons/`
- Outputs: `active:<n>` on line 1, then `workspace_number:app1|path1,app2|path2,...` per line
- Uses `mdfind` to locate `.app` bundles by bundle ID

### JankyBorders (`jankyborders/bordersrc`, 9 lines)
- **Style**: round, width 6px, order above
- **Active color**: glow pink (`#ff63ff`)
- **Inactive color**: gradient (top-left green, bottom-right pink)
- **Background**: semi-transparent dark (`#2c2e34` at 19% alpha)
- **Installed via**: `felixkratz/formulae/borders` brew tap, started as brew service

### AeroSpace (`aero space/aerospace.toml`)
- **Gaps**: inner 8px, outer top 50px (for menubar), other sides 5px
- **Borders**: 5px, active `#cba6f7` (mauve), inactive `#585b70` (surface2)
- **9 workspaces** with Option+1-9 switching, Option+Shift+1-9 to move windows
- **Focus/move**: vim-style (Option+h/j/k/l, Option+Shift+h/j/k/l)
- **SketchyBar integration**: triggers `aerospace_workspace_change` event on workspace switch
- **Autostart**: `start-at-login = true`

### fastfetch (`fastfetch/config.jsonc`, 172 lines)
- **Logo**: random cat PNG (Kitty protocol), width 27, positioned left
- **Separator**: `` in gray
- **Color**: keys white, title/output bright, separator dark gray
- **Modules**: title, separator, OS, host, kernel, uptime, packages (combined), shell, terminal, separator, CPU (temp + P-core count), GPU (temp), memory, disk (/), separator, battery, local IP, locale, color palette

---

## Installer Flow (`configure.sh`)

1. Sources `scripts/lib.sh` (sets `DOTFILES` and `BACKUP_DIR` variables)
2. Runs each component's `install.sh` in order:
   - **aero space/install.sh** — installs AeroSpace via brew, symlinks `aerospace.toml`
   - **jankyborders/install.sh** — installs `felixkratz/formulae/borders` via brew, symlinks `bordersrc`, starts brew service
   - **ghostty/install.sh** — symlinks config to macOS/Linux path, links `ghostty-init`
   - **fastfetch/install.sh** — copies JSONC (with logo placeholder substitution via `sed_i`), copies cat images, links `catfetch`, symlinks `assets/cats` to `~/Pictures/cats`
   - **omniwm/install.sh** — symlinks `settings.toml` (macOS only, skips on other OS)
   - **sketchybar/install.sh** — taps brew, installs sketchybar/lua/sf-symbols, installs SbarLua from GitHub, installs sketchybar-app-font, copies widget PNG icons, symlinks all sketchybar/ files (except install.sh), starts sketchybar service
   - **nvim/install.sh** — installs neovim via brew/pacman, symlinks `init.lua`
3. Each sub-install.sh is idempotent (uses `link_file` with backup, `--force` installs)

---

## Important Paths

| Config | Destination |
|--------|-------------|
| AeroSpace | `~/.config/aerospace/aerospace.toml` |
| Ghostty (macOS) | `~/Library/Application Support/com.mitchellh.ghostty/config` |
| Ghostty (Linux) | `~/.config/ghostty/config` |
| JankyBorders | `~/.config/borders/bordersrc` |
| Neovim | `~/.config/nvim/init.lua` |
| OmniWM | `~/.config/omniwm/settings.toml` |
| SketchyBar | `~/.config/sketchybar/` |
| fastfetch | `~/.config/fastfetch/config.jsonc` |
| Cat images | `~/.config/fastfetch/cats/` + `~/Pictures/cats/` (symlink) |
| Scripts | `~/.local/bin/catfetch`, `~/.local/bin/ghostty-init` |
| Backups | `~/.dotfiles-backup-<timestamp>/` |

---

## Patterns & Rules for Editing

1. **Catppuccin Mocha colors must be consistent** across all files. If adding a new SketchyBar color, add it to `colors.lua` only when it is actually referenced.
2. **Icons** — SketchyBar widget icons live in `assets/icons/` and are copied to `~/.config/sketchybar/app-icons/`; workspace app icons are extracted by `spaces_helper.py`. Fastfetch may use Nerd Font v3 glyphs.
3. **Transparency** — stick to the 0.5 bg / 30 blur pattern for terminals, and `0x60XXXXXX` / `0x90XXXXXX` alpha patterns for sketchybar backgrounds.
4. **Hack Nerd Font Mono** is the single font family used everywhere. Don't add other font families without a strong reason.
5. **No shell rc files** should be added to this repo — it's strictly WM/visual layer.
6. **Installer scripts** must be idempotent, use `link_file()` from `lib.sh`, handle macOS/Linux differences via `uname -s`, and support both standalone execution and sourcing from `configure.sh`.
7. **Sketchybar Lua** uses the `sbar` global from SbarLua. Follow the existing pattern: `require()` for modules, `sbar.add()` for items, event subscriptions via `sbar.subscribe()`.
8. **OmniWM hotkeys** — `Unassigned` bindings are reserved for future use. Don't remove them; add new hotkeys by changing `Unassigned` to a real binding.
9. **Python helpers** — use only stdlib + `subprocess` (no pip dependencies). macOS-specific tools (`sips`, `mdfind`, `omniwmctl`) are expected.
10. **Lua style**: 2-space indentation, no trailing semicolons, `snake_case` for locals, `require("module")` at top. Align table keys with spaces.
11. **Bash style**: `set -e` at top, `snake_case` for local variables, `"$var"` quoting, `/dev/null` redirection for noisy commands with `|| true`.
