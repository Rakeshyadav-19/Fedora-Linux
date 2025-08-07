#!/bin/bash

set -e

# Install required packages
echo "Installing required packages..."
sudo dnf install -y tmux zsh figlet eza xclip git

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" 2>/dev/null || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" 2>/dev/null || true


# Link .zshrc
echo "Linking .zshrc..."
if [ -f "$PWD/.zshrc" ]; then
  ln -sf "$PWD/.zshrc" "$HOME/.zshrc"
fi

# Link tmux config
if [ -f "$PWD/tmux/.tmux.conf" ]; then
  ln -sf "$PWD/tmux/.tmux.conf" "$HOME/.tmux.conf"
fi

# Link kitty config
if [ -f "$PWD/kitty/kitty.conf" ]; then
  mkdir -p "$HOME/.config/kitty"
  ln -sf "$PWD/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
fi

# Link nvim config
if [ -d "$PWD/nvim" ]; then
  mkdir -p "$HOME/.config/nvim"
  ln -sf "$PWD/nvim/init.lua" "$HOME/.config/nvim/init.lua"
  ln -sf "$PWD/nvim/lua" "$HOME/.config/nvim/lua"
  ln -sf "$PWD/nvim/lazy-lock.json" "$HOME/.config/nvim/lazy-lock.json"
fi

# Make scripts executable
chmod +x Scripts/*.sh

# Install pokemon-colorscripts
if [ ! -d "$HOME/.local/bin/pokemon-colorscripts" ]; then
  echo "Installing pokemon-colorscripts..."
  cd pokemon-colorscripts
  ./install.sh
  cd ..
fi

echo "Setup complete! Please restart your terminal or run 'zsh' to start using your new environment."