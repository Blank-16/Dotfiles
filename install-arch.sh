#!/usr/bin/env bash
set -euo pipefail

NVM_VERSION="${NVM_VERSION:-v0.40.3}"
NODE_VERSION="${NODE_VERSION:-lts/*}"

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

install_nvm_and_node() {
  if [ ! -s "$HOME/.nvm/nvm.sh" ]; then
    curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
  fi

  # shellcheck disable=SC1091
  . "$HOME/.nvm/nvm.sh"
  nvm install "$NODE_VERSION"
  nvm alias default "$NODE_VERSION"
  nvm use default
  npm install -g npm@latest
}

enable_docker_for_user() {
  sudo systemctl enable --now docker
  sudo usermod -aG docker "$USER"
}

set_zsh_default() {
  local zsh_path
  zsh_path="$(command -v zsh)"

  if [ "$SHELL" != "$zsh_path" ]; then
    chsh -s "$zsh_path"
  fi
}

main() {
  require_command pacman
  require_command sudo

  sudo pacman -Syu --noconfirm
  sudo pacman -S --needed --noconfirm ca-certificates curl gnupg git tmux ripgrep \
    zsh neovim base-devel python python-pip go docker docker-buildx docker-compose code

  install_nvm_and_node
  enable_docker_for_user
  set_zsh_default

  echo "Arch-based setup complete. Log out and back in for docker group and shell changes."
  echo "The 'code' package is Code - OSS from Arch repositories. Use an AUR helper for Microsoft's branded VS Code build."
}

main "$@"
