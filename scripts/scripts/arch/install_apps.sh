#!/usr/bin/env bash

if ! command -v yay &>/dev/null; then
    echo "yay is not installed. Installing yay-bin..."

    sudo pacman -S --needed --noconfirm git base-devel

    TEMP_DIR="$(mktemp -d)"
    trap 'rm -rf "$TEMP_DIR"' EXIT

    git clone --depth 1 https://aur.archlinux.org/yay-bin.git "$TEMP_DIR/yay-bin"

    (
        cd "$TEMP_DIR/yay-bin"
        makepkg -si --noconfirm
    )
fi

APPS=(
    # GUI Apps
    1password
    kitty
    google-chrome
    libreoffice-fresh
    thunderbird
    # Terminal apps
    tmux
    yazi
    openconnect
    neovim
    stow
    tree
    git
    base-devel
    curl
    grep
    fzf
    bat
    lazygit
    man-db
    docker
    docker-compose
    networkmanager-openconnect
)

if ((${#APPS[@]})); then
    echo "Installing packages..."
    yay -S --needed --noconfirm \
        --answerdiff=None \
        --answeredit=None \
        "${APPS[@]}"
fi
