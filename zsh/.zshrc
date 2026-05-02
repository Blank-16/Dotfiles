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
alias src='source ~/.zshrc'

# Docker Aliases
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias cls='clear'

# --- 6. Completion Tuning ---
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
