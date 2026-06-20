#!/usr/bin/env zsh

set -euo pipefail

TOOL_DIR="${DOTFILES_PATH:=$PWD}/yabai"

[ ! -d "$HOME/.config/yabai" ] && mkdir -p "$HOME/.config/yabai"
ln -sf "$TOOL_DIR/yabairc" "$HOME/.config/yabai/yabairc"
