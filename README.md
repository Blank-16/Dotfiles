# Dotfiles


***Nerd Font are necessary (currently using Jet Brains Mono Nerd Font)***


### essential files first 
```
sudo apt update && sudo apt install -y \
  zsh \
  git \
  curl \
  neovim \
  ripgrep \
  build-essential

```

### Downloads and installs Oh My Zsh 

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

```

### Tmux Plugin Manager 
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Zsh plugin 

```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### Change Default shell to zsh 
` chsh -s $(which zsh) `

### clone files to config files 
```
# neovim config dir 
mkdir -p ~/.config/nvim

cp init.lua ~/.config/nvim/init.lua
cp .zshrc ~/.zshrc
```



