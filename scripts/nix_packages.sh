#!/usr/bin/env bash
set -euo pipefail

packages=(
  bash
  bat
  eza
  fd
  fzf
  hexyl
  jq
  peco
  ripgrep
  starship
  tmux
  tokei
  yazi
  zoxide
)

installed=$(nix profile list 2>/dev/null | grep 'Name:' | awk '{print $2}' || true)

for pkg in "${packages[@]}"; do
  if echo "$installed" | grep -qx "$pkg"; then
    echo "skip: $pkg (already installed)"
  else
    echo "install: $pkg"
    nix profile add "nixpkgs#$pkg"
  fi
done
