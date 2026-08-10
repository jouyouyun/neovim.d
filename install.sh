#!/bin/sh
set -eu

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
CONFIG_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/nvim

mkdir -p "$CONFIG_DIR"
cp -R "$DIR/init.lua" "$DIR/lua" "$CONFIG_DIR/"

printf 'Neovim configuration installed to %s\n' "$CONFIG_DIR"
printf 'Start Neovim and run :Lazy to inspect plugins.\n'
