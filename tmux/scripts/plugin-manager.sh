#!/usr/bin/env bash
# ============================================
# tmux plugin auto-manager
# Auto-install on first launch, check updates afterwards
# ============================================

set -euo pipefail

PLUGIN_DIR="${HOME}/.config/tmux/plugins"
LOG_FILE="${PLUGIN_DIR}/.update.log"

PLUGINS=(
    "tmux-plugins/tmux-resurrect"
    "tmux-plugins/tmux-continuum"
)

mkdir -p "$PLUGIN_DIR"

install_plugin() {
    local plugin=$1
    local name=$(basename "$plugin")
    local target="${PLUGIN_DIR}/${name}"

    if [[ ! -d "$target" ]]; then
        git clone --depth 1 "https://github.com/${plugin}.git" "$target" 2>/dev/null
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installed: $plugin" >> "$LOG_FILE"
    fi
}

update_plugin() {
    local plugin=$1
    local name=$(basename "$plugin")
    local target="${PLUGIN_DIR}/${name}"

    if [[ -d "$target" ]]; then
        (cd "$target" && git pull --quiet 2>/dev/null) &
    fi
}

main() {
    for plugin in "${PLUGINS[@]}"; do
        install_plugin "$plugin"
        update_plugin "$plugin"
    done
}

main
