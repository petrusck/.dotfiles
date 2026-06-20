#!/usr/bin/env zsh

set -euo pipefail

TOOL_DIR="${DOTFILES_PATH:=$PWD}/starship"

[ ! -d "$HOME/.config/starship" ] && mkdir -p "$HOME/.config/starship"
ln -sf "$TOOL_DIR/starship.toml" "$HOME/.config/starship/starship.toml"
