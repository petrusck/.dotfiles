#!/usr/bin/env zsh

set -euo pipefail

TOOL_DIR="${DOTFILES_PATH:=$PWD}/hammerspoon"

ln -sfn "$TOOL_DIR" "$HOME/.hammerspoon"
