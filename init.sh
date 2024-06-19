#!/usr/bin/env sh

set -e

# Download shm if it doesn't exist
if ! command -v "shm" >/dev/null; then
  curl -sSL https://raw.githubusercontent.com/erikjuhani/shm/main/shm.sh | sh
  if ! command -v "shm" >/dev/null; then
    printf "%s" "Initialize PATH for shm, then run this script again"
    exit 2
  fi
fi

shm get erikjuhani/tm
shm get erikjuhani/ql
shm get erikjuhani/git-fixup

if ! command -v "brew" >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # TODO: Figure out a way to determine when we are installing from scratch
  # Maybe an env var.
  # Only run this if we are installing from scratch!
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/erikjuhani/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew bundle

# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
