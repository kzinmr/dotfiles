#!/bin/bash

sudo xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo PATH="/usr/local/bin:${PATH}" >> ~/.bash_profile

brew install curl
brew install zsh
brew install tmux
brew install tree
brew install git
brew install gh

/bin/zsh prezto.zsh
chsh -s "$(which zsh)"

# Apps
brew install --cask visual-studio-code

# Programming
curl -LsSf https://astral.sh/uv/install.sh | sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
