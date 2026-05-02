#!/usr/bin/env bash
set -euo pipefail

NVM_VERSION="${NVM_VERSION:-v0.40.3}"
GO_PACKAGE="${GO_PACKAGE:-golang-go}"
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

detect_docker_repo() {
  # shellcheck disable=SC1091
  . /etc/os-release

  case "${ID:-}" in
    debian)
      DOCKER_DISTRO="debian"
      DOCKER_CODENAME="${VERSION_CODENAME:-}"
      ;;
    ubuntu)
      DOCKER_DISTRO="ubuntu"
      DOCKER_CODENAME="${VERSION_CODENAME:-}"
      ;;
    *)
      if [ "${UBUNTU_CODENAME:-}" != "" ]; then
        DOCKER_DISTRO="ubuntu"
        DOCKER_CODENAME="$UBUNTU_CODENAME"
      elif [ "${VERSION_CODENAME:-}" != "" ]; then
        DOCKER_DISTRO="debian"
        DOCKER_CODENAME="$VERSION_CODENAME"
      else
        echo "Could not detect Debian or Ubuntu codename for Docker repository." >&2
        exit 1
      fi
      ;;
  esac

  if [ "$DOCKER_CODENAME" = "" ]; then
    echo "Could not detect Debian or Ubuntu codename for Docker repository." >&2
    exit 1
  fi
}

set_zsh_default() {
  local zsh_path
  zsh_path="$(command -v zsh)"

  if [ "$SHELL" != "$zsh_path" ]; then
    chsh -s "$zsh_path"
  fi
}

main() {
  require_command apt-get
  require_command sudo

  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get install -y ca-certificates curl gnupg lsb-release git tmux ripgrep \
    zsh neovim build-essential python3 python3-pip python3-venv python3-dev \
    "$GO_PACKAGE"

  sudo install -m 0755 -d /etc/apt/keyrings
  detect_docker_repo
  if [ ! -f /etc/apt/keyrings/docker.asc ]; then
    curl -fsSL "https://download.docker.com/linux/${DOCKER_DISTRO}/gpg" | sudo tee /etc/apt/keyrings/docker.asc >/dev/null
    sudo chmod a+r /etc/apt/keyrings/docker.asc
  fi
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/${DOCKER_DISTRO} ${DOCKER_CODENAME} stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

  if [ ! -f /etc/apt/keyrings/packages.microsoft.gpg ]; then
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc |
      gpg --dearmor |
      sudo tee /etc/apt/keyrings/packages.microsoft.gpg >/dev/null
    sudo chmod a+r /etc/apt/keyrings/packages.microsoft.gpg
  fi
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |
    sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null

  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin \
    docker-compose-plugin code

  install_nvm_and_node
  enable_docker_for_user
  set_zsh_default

  echo "Debian-based setup complete. Log out and back in for docker group and shell changes."
}

main "$@"
