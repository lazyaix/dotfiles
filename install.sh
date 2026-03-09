#!/usr/bin/env bash
# dotfiles install script (macOS / Linux / WSL)
#
# Steps:
#   1. Detect platform (macOS / Linux / WSL)
#   2. Backup existing configs
#   3. Create common symlinks:
#      - nvim/   → ~/.config/nvim/
#      - tmux/   → ~/.config/tmux/
#      - wezterm/ → ~/.config/wezterm/
#      - git/.gitconfig → ~/.gitconfig
#      - git/.gitignore_global → ~/.gitignore_global
#   4. Source platform-specific fragments from platform/{os}/
#   5. Print install summary
#
# TODO: implement
