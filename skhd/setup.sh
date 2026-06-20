#!/usr/bin/env zsh

set -euo pipefail

TOOL_DIR="${DOTFILES_PATH:=$PWD}/skhd"

[ ! -d "$HOME/.config/skhd" ] && mkdir -p "$HOME/.config/skhd"
ln -sf "$TOOL_DIR/skhdrc" "$HOME/.config/skhd/skhdrc"
