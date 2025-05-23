# Fedora-Linux Dotfiles & Scripts

Welcome to your personal Fedora-Linux configuration!  
This repository contains handy scripts, tmux configuration, and shell customizations to supercharge your Linux experience.

---

## 📁 Structure

- **pokemon-colorscripts/**  
  Fun Pokémon-themed terminal color scripts.
- **Scripts/**  
  Useful shell scripts for system management:
  - `update.sh` – One-command system update & cleanup.
  - `Power-Saving.sh` – Easily toggle GNOME power-saving settings.
  - `HotspotConnections.sh` – List devices connected to your Wi-Fi hotspot.
- **tmux/**  
  Custom tmux configuration for a productive terminal workflow.
- **.zshrc**  
  Zsh configuration with Oh My Zsh, plugins, and aliases.

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
- Install required packages (`tmux`, `zsh`, `figlet`, `eza`, `xclip`, etc.)
- Set up Oh My Zsh and plugins
- Link configuration files to your home directory
- Make scripts executable

---

## 🛠️ Scripts

- **System Update:**  
  `sysup` (alias) or `Scripts/update.sh`
- **Power Saving:**  
  `power-saver` (alias) or `Scripts/Power-Saving.sh`
- **Hotspot Devices:**  
  `hotscon` (alias) or `Scripts/HotspotConnections.sh`

---

## 🎨 Terminal Customization

- **pokemon-colorscripts**  
  Shows a random Pokémon on each terminal start!
- **tmux**  
  Modern, mouse-enabled, and visually enhanced tmux config.

---

## 📸 Demo

![pokemon-colorscripts-demo](pokemon-colorscripts/demo_images/pokemon-colorscripts-demo.gif)

---

## 📦 Requirements

- Fedora Linux
- `tmux`, `zsh`, `figlet`, `eza`, `xclip`, `git`
- GNOME (for power-saving script)

---

## 📚 License

See [pokemon-colorscripts/LICENSE.txt](pokemon-colorscripts/LICENSE.txt) for Pokémon scripts license.

---

## 🙏 Credits

- [pokemon-colorscripts](https://github.com/aksh1618/pokemon-colorscripts)
- [Oh My Zsh](https://ohmyz.sh/)
- [tmux](https://github.com/tmux/tmux)

---

Happy hacking! 🚀