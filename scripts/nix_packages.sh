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
  uv
  yazi
  zoxide
)

uv_tools=(
  skill-seekers
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

# uv tools
if command -v uv &>/dev/null; then
  installed_uv_tools=$(uv tool list 2>/dev/null | awk '{print $1}' || true)
  for tool in "${uv_tools[@]}"; do
    if echo "$installed_uv_tools" | grep -qx "$tool"; then
      echo "skip uv tool: $tool (already installed)"
    else
      echo "install uv tool: $tool"
      uv tool install "$tool"
    fi
  done
else
  echo "uv not found, skipping uv tools"
fi
