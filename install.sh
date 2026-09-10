#!/usr/bin/env bash
set -euo pipefail
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$DOTFILES/$1" dst="$HOME/$2"
  [ -e "$src" ] || { echo "skip    $1 (not in repo)"; return; }
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "backup  $dst -> $dst.bak"
    mv "$dst" "$dst.bak"
  fi
  ln -sfn "$src" "$dst"
  echo "linked  $dst"
}

# machine-independent
link nvim/.config/nvim          .config/nvim
link git/.gitconfig             .gitconfig
link gdb/.gdbinit               .gdbinit
link shell/.config/shell        .config/shell

# arch only — skipped automatically if not in the repo
link hypr/.config/hypr          .config/hypr
link kitty/.config/kitty        .config/kitty
link ironbar/.config/ironbar    .config/ironbar
