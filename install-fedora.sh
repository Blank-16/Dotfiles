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
  require_command dnf
  require_command sudo

  sudo dnf upgrade -y
  sudo dnf install -y dnf-plugins-core ca-certificates curl gnupg2 git tmux ripgrep \
    zsh neovim python3 python3-pip python3-devel golang
  sudo dnf group install -y development-tools || sudo dnf group install -y "Development Tools"

  sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo tee /etc/yum.repos.d/vscode.repo >/dev/null <<'REPO'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
REPO

  sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin \
    docker-compose-plugin code

  install_nvm_and_node
  enable_docker_for_user
  set_zsh_default

  echo "Fedora-based setup complete. Log out and back in for docker group and shell changes."
}

main "$@"
