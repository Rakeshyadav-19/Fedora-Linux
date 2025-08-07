# Fedora-Linux Dotfiles & Scripts

Welcome to your personal Fedora-Linux configuration!  
This repository contains handy scripts, tmux configuration, and shell customizations to supercharge your Linux experience.

---

## 📁 Structure

- **pokemon-colorscripts/**  
  Pokémon-themed terminal color scripts, installer, and demo images.
- **Scripts/**  
  System management scripts:
  - `update.sh` – System update & cleanup.
  - `Power-Saving.sh` – GNOME power-saving toggle.
  - `HotspotConnections.sh` – List Wi-Fi hotspot devices.
- **tmux/**  
  Custom tmux configuration (`.tmux.conf`).
- **kitty/**  
  Kitty terminal configuration (`kitty.conf`).
- **nvim/**  
  Neovim configuration:
  - `init.lua`, `lua/` (keymaps, lsp, plugins, theme, options)
  - `lazy-lock.json` for plugin management

---

---

## 🚀 Quick Start

### 1. Clone the Repository

```sh
git clone https://github.com/yourusername/Fedora-Linux.git
cd Fedora-Linux
```

### 2. Run the Setup Script

```sh
chmod +x install.sh
./install.sh
```

This will:

- Install required packages (`tmux`, `zsh`, `figlet`, `eza`, `xclip`, `git`)
- Set up Oh My Zsh and plugins
- Link configuration files to your home directory:
  - `.zshrc`
  - `.tmux.conf`
  - `kitty.conf` (to `~/.config/kitty/`)
  - `nvim` config (to `~/.config/nvim/`)
- Make scripts executable
- Install pokemon-colorscripts

---

## 🛠️ Scripts

- **System Update:**  
  `sysup` (alias) or `Scripts/update.sh`
- **Power Saving:**  
  `power-saver` (alias) or `Scripts/Power-Saving.sh`
- **Hotspot Devices:**  
  `hotscon` (alias) or `Scripts/HotspotConnections.sh`

---

## 🎨 Terminal & Editor Customization

- **pokemon-colorscripts**  
  Shows a random Pokémon on each terminal start!
- **tmux**  
  Modern, mouse-enabled tmux config.
- **kitty**  
  Beautiful Kitty terminal theme.
- **nvim**  
  Lua-based Neovim config with plugins and LSP.

---

## 📸 Demo

![pokemon-colorscripts-demo](pokemon-colorscripts/demo_images/pokemon-colorscripts-demo.gif)

---

## 📦 Requirements

- Fedora Linux
- `tmux`, `zsh`, `figlet`, `eza`, `xclip`, `git`
- Kitty terminal (for `kitty/kitty.conf`)
- Neovim (for `nvim/`)
- GNOME (for power-saving script)

---

## 📚 License

See [pokemon-colorscripts/LICENSE.txt](pokemon-colorscripts/LICENSE.txt) for Pokémon scripts license.

---

## 🙏 Credits

- [pokemon-colorscripts](https://github.com/aksh1618/pokemon-colorscripts)
- [Oh My Zsh](https://ohmyz.sh/)
- [tmux](https://github.com/tmux/tmux)
- [kitty](https://sw.kovidgoyal.net/kitty/)
- [neovim](https://neovim.io/)

---

Happy hacking! 🚀
