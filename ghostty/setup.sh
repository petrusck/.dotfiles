#!/usr/bin/env zsh

set -euo pipefail

TOOL_DIR="${DOTFILES_PATH:=$PWD}/ghostty"

[ ! -d "$HOME/.config/ghostty" ] && mkdir -p "$HOME/.config/ghostty"
ln -sf "$TOOL_DIR/config" "$HOME/.config/ghostty/config"
