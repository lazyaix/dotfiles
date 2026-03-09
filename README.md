# dotfiles

Personal development environment configurations for macOS / Linux / Windows.

## What's Included

| Directory | Description | macOS | Linux | Windows |
|-----------|-------------|:-----:|:-----:|:-------:|
| `nvim/` | Neovim editor | o | o | o |
| `tmux/` | Terminal multiplexer | o | o | WSL |
| `wezterm/` | WezTerm terminal | o | o | o |
| `git/` | Git global config | o | o | o |

## Structure

```
dotfiles/
├── install.sh              # macOS/Linux install script
├── install.ps1             # Windows install script (PowerShell)
├── nvim/                   # → ~/.config/nvim/
├── tmux/                   # → ~/.config/tmux/
├── wezterm/                # → ~/.config/wezterm/
├── git/                    # → ~/.gitconfig, ~/.gitignore_global
├── platform/               # Platform-specific config fragments
│   ├── macos/
│   ├── linux/
│   └── windows/
└── scripts/                # Helper scripts
    ├── utils.sh
    ├── backup.sh
    └── uninstall.sh
```

## Installation

### macOS / Linux

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
```

### Windows (PowerShell as Admin)

```powershell
git clone <repo-url> ~\dotfiles
cd ~\dotfiles
.\install.ps1
```

## Platform Handling

Shared configurations live in each tool's directory. Platform-specific settings are placed as fragments under `platform/{os}/` and loaded via `source` / `require` from the main configs.

## Uninstall

```bash
./scripts/uninstall.sh
```
