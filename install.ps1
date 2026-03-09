# dotfiles install script (Windows PowerShell)
#
# Steps:
#   1. Create symlinks (requires admin privileges):
#      - nvim/   → $env:LOCALAPPDATA\nvim\
#      - wezterm/ → $env:USERPROFILE\.config\wezterm\
#      - git/.gitconfig → $env:USERPROFILE\.gitconfig
#      - git/.gitignore_global → $env:USERPROFILE\.gitignore_global
#   2. Load Windows-specific configs from platform/windows/
#   3. Prompt user to install tmux via WSL
#   4. Print install summary
#
# TODO: implement
