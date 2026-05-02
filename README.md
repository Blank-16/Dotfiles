# Dotfiles

Personal setup for zsh, tmux, and Neovim.

## Target Locations

| Repo file | Fresh install location |
| --- | --- |
| `zsh/.zshrc` | `~/.zshrc` |
| `tmux/tmux.conf` | `~/.tmux.conf` |
| `neovim/init.lua` | `~/.config/nvim/init.lua` |

## Prerequisites

Install these before copying the config files:

- `git`
- `curl`
- `zsh`
- `tmux`
- `neovim`
- `ripgrep`
- `build-essential`
- A Nerd Font, currently JetBrainsMono Nerd Font

On Ubuntu or WSL Ubuntu:

```sh
sudo apt update
sudo apt install -y zsh git curl tmux neovim ripgrep build-essential
```

The tmux clipboard binding in this config uses `clip.exe`, so it is intended for WSL. On native Linux, replace that binding with a Linux clipboard tool such as `xclip` or `wl-copy`.

## Install Shell Dependencies

Install Oh My Zsh:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

Install the zsh autosuggestions plugin:

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
```

Set zsh as the default shell:

```sh
chsh -s "$(which zsh)"
```

Log out and back in after changing the shell.

## Install tmux Plugin Manager

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

After copying `tmux/tmux.conf`, start tmux and press `Ctrl+a` then `Shift+i` to install the tmux plugins.

## Copy Config Files

From the root of this repository:

```sh
mkdir -p ~/.config/nvim

cp zsh/.zshrc ~/.zshrc
cp tmux/tmux.conf ~/.tmux.conf
cp neovim/init.lua ~/.config/nvim/init.lua
```

## Neovim Plugins

The Neovim config bootstraps `lazy.nvim` automatically on first launch. Open Neovim after copying the file:

```sh
nvim
```

Lazy will install plugins into Neovim's standard data directory.

## tmux Notes

The tmux prefix is `Ctrl+a`, not the default `Ctrl+b`.

Useful bindings:

- `Ctrl+a`, then `h/j/k/l`: move between panes
- `Ctrl+a`, then `r`: reload `~/.tmux.conf`
- `Ctrl+a`, then `Shift+i`: install TPM plugins
- `Ctrl+a`, then `[`: enter copy mode

More tmux notes are in `tmux/tmux.readme.md` and `tmux/tmux_CheatSheet.md`.


