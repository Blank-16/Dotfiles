# Install location: ~/.zshrc
# zshrc config file 

# --- 1. Framework & Theme ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="ys" 

# --- 2. Plugins (Strictly the essentials) ---
plugins=(
  git 
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# --- 3. Environment & Performance ---
export LANG=en_US.UTF-8
setopt NO_NOMATCH          # Fixes wildcard errors
setopt AUTO_CD             # Type directory to CD automatically
export MANPAGER="nvim +Man!"

# --- 4. Keybindings (For Autosuggestions) ---
bindkey '^[[F' end-of-line
bindkey '^[[C' forward-word

# --- 5. Editor & System Aliases ---
alias v='nvim'
alias vf='nvim .'
alias edv='nvim ~/.config/nvim/init.lua'
alias edz='nvim ~/.zshrc'
alias updateSys='sudo apt update && sudo apt upgrade'

# git aliases
alias gitc='git commit -m'
alias gitLog='git log | v'
alias gitlog='git log --oneline --graph --all --decorate'
alias gita='git add .'
alias gits='git status'

# --- 6. Completion Tuning ---
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

. "$HOME/.local/bin/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
