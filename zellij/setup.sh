#!/usr/bin/env zsh

set -euo pipefail

TOOL_DIR="${DOTFILES_PATH:=$PWD}/zellij"

[ ! -d "$HOME/.config/zellij" ] && mkdir -p "$HOME/.config/zellij"
ln -sf "$TOOL_DIR/config.kdl" "$HOME/.config/zellij/config.kdl"
