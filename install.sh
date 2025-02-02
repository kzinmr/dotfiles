#!/bin/bash

BACKUP_DIR="$HOME/.config_backup/$(date +%Y%m%d_%H%M%S)"
CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/configs"

backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        mkdir -p "$BACKUP_DIR"
        cp "$file" "$BACKUP_DIR/"
    fi
}

deploy_config() {
    local src="$1"
    local dest="$2"

    backup_file "$dest"

    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
}

detect_os() {
    if [ -f /etc/debian_version ]; then
        echo "debian"
    elif [ -f /etc/fedora-release ]; then
        echo "fedora"
    elif [ -f /etc/arch-release ]; then
        echo "arch"
    elif [ "$(uname)" == "Darwin" ]; then
        echo "mac"
    else
        echo "unknown"
    fi
}

# メイン処理
main() {
    local os=$(detect_os)

    # OS固有のセットアップ
    if [ -f "scripts/${os}.sh" ]; then
        # shellcheck source=/dev/null
        source "scripts/${os}.sh"
    else
        echo "Warning: No specific setup for ${os}"
    fi

    # 共通設定の配置
    deploy_config "$CONFIG_DIR"/zsh/env.zsh "$HOME"/env.zsh
    echo "source $HOME/env.zsh" >> "$HOME"/.zprofile
    deploy_config "$CONFIG_DIR"/git/.gitignore "$HOME"/.gitignore
    git config --global core.excludesfile "$HOME"/.gitignore

    # 環境固有の設定があれば適用
    if [ -f "configs/hosts/$(hostname)/zshrc" ]; then
        cat "configs/hosts/$(hostname)/zshrc" >> "$HOME/.zshrc"
    fi

    echo "Configuration deployed successfully"
}

main "$@"
