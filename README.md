# dotfiles

Personal config shared between an Arch desktop (Hyprland) and Ubuntu on WSL.

The real files live in this repo. `install.sh` symlinks them into `$HOME`, so
editing `~/.config/nvim/init.lua` edits the repo directly — there is no copy
step and nothing to keep in sync.

## Install on a new machine

    git clone git@github.com:<you>/dotfiles.git ~/dotfiles
    ~/dotfiles/install.sh

Anything already at a target path is moved to `<path>.bak` first, so an
existing config is never destroyed. Packages missing from the repo are
skipped, which is how the same script serves both machines.

## Contents

| Package      | Links to           | What it is                                  |
|--------------|--------------------|---------------------------------------------|
| `nvim/`      | `~/.config/nvim`   | Editor: kickstart + Claude Code, yazi, clangd for ARM |
| `git/`       | `~/.gitconfig`     | Identity, aliases, global ignore            |
| `gdb/`       | `~/.gdbinit`       | Debugger defaults, project auto-load permission |
| `shell/`     | `~/.config/shell/` | PATH and aliases, sourced from `.bashrc`    |
| `hypr/`      | `~/.config/hypr`   | Hyprland (Arch only)                        |
| `kitty/`     | `~/.config/kitty`  | Terminal (Arch only)                        |
| `ironbar/`   | `~/.config/ironbar`| Status bar (Arch only)                      |

## Prerequisites

### Arch

    yay -S --needed \
      arm-none-eabi-gcc arm-none-eabi-newlib arm-none-eabi-binutils arm-none-eabi-gdb \
      openocd stlink cmake ninja \
      neovim ripgrep fd yazi wl-clipboard git \
      stm32cubemx stm32cubeprog

### Ubuntu / WSL

    sudo apt install -y build-essential cmake ninja-build git curl unzip \
      ripgrep fd-find wl-clipboard \
      gcc-arm-none-eabi binutils-arm-none-eabi libnewlib-arm-none-eabi \
      libstdc++-arm-none-eabi-newlib gdb-multiarch openocd stlink-tools

Neovim from apt is too old. Install from the release tarball:

    cd /tmp
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
    sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

Yazi is not packaged for Ubuntu — grab the binary from its GitHub releases.

## Shell

`.bashrc` is deliberately not managed, because the distro defaults differ.
Add one line to the bottom of each machine's stock `.bashrc`:

    [ -f ~/.config/shell/common.sh ] && source ~/.config/shell/common.sh

## Neovim keys

Leader is Space.

| Keys           | Action                        |
|----------------|-------------------------------|
| `<leader>sf`   | find files                    |
| `<leader>sg`   | live grep                     |
| `<leader>cd`   | yazi in cwd                   |
| `<leader>ac`   | toggle Claude                 |
| `<leader>as`   | send visual selection to Claude |
| `<leader>aa`   | accept Claude's diff (or `:w`) |
| `<leader>ad`   | reject Claude's diff (or `:q`) |
| `<leader>db`   | toggle breakpoint             |
| `<F5>`         | start / continue debugging    |

Plugin manager is `vim.pack`, built into Neovim 0.12 — not lazy.nvim.
Inspect plugins with `:lua vim.pack.update(nil, { offline = true })`,
update with `:lua vim.pack.update()`. `nvim-pack-lock.json` is committed
so both machines get identical plugin versions.

## Adding a package

    mkdir -p <name>/<path relative to home>
    mv ~/<real config> <name>/<path>/
    # add a `link` line to install.sh
    ./install.sh

## Removing a link

    rm ~/.config/<thing>          # it's only a symlink

## Cross-machine gotchas

- `arm-none-eabi-gdb` exists on Arch; Ubuntu only has `gdb-multiarch`.
  `nvim/.config/nvim/lua/custom/dap.lua` detects which and adapts.
- `fd` is called `fdfind` on Ubuntu.
- `add-auto-load-safe-path` in `.gdbinit` assumes repos live under `~/git`.

## Never commit

`~/.ssh/`, `.git-credentials`, anything holding a token, or the whole
`~/.claude/` directory (it caches credentials — link only `CLAUDE.md` if
you want to sync that).
