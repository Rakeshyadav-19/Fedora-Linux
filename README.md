# 🚀 Fedora-Linux Dotfiles & Development Environment

A comprehensive, production-ready Fedora Linux configuration with modern terminal tools, development environment, and productivity scripts.

[![Fedora](https://img.shields.io/badge/Fedora-39+-blue.svg)](https://getfedora.org/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](#-license)
[![Shell](https://img.shields.io/badge/shell-zsh-brightgreen.svg)](https://www.zsh.org/)

---

## ✨ Features

- **Modern Terminal Experience**: Zsh with Oh My Zsh, autosuggestions, and syntax highlighting
- **Beautiful UI**: Catppuccin theme across all applications
- **Developer Tools**: Neovim with LSP, Kitty terminal, Tmux multiplexer
- **System Scripts**: Automated system maintenance and power management
- **File Manager**: Superfile with modern UI
- **Terminal Clock**: Peaclock with multiple themes
- **Fun Elements**: Pokémon colorscripts for terminal startup

---

## 📁 Structure

- **pokemon-colorscripts/**  
  Pokémon-themed terminal color scripts with 900+ sprites
- **Scripts/**  
  System management and utility scripts:
  - `update.sh` – DNF system update, cleanup, and flatpak updates
  - `Power-Saving.sh` – GNOME power profile switching
  - `HotspotConnections.sh` – Network hotspot device monitoring
- **tmux/**  
  Tmux configuration with TPM plugin manager and modern styling
- **kitty/**  
  Kitty terminal with Catppuccin theme and Wayland support
- **nvim/**  
  Complete Neovim IDE setup:
  - LSP servers for 10+ languages
  - Lazy.nvim plugin manager
  - File explorer, fuzzy finder, Git integration
  - Auto-completion and debugging support
- **superfile/**  
  Modern terminal file manager configuration
- **peaclock/**  
  Terminal clock with multiple visual themes
- **.zshrc**  
  Zsh configuration with aliases, exports, and tmux integration

---

## 🚀 Quick Start

### Prerequisites

- Fedora Linux 38+ (recommended: Fedora 39+)
- Internet connection for package installation
- Git (usually pre-installed)

### 1. Clone the Repository

```bash
git clone https://github.com/Rakeshyadav-19/Fedora-Linux.git ~/Fedora-Linux
cd ~/Fedora-Linux
```

### 2. Run the Setup Script

```bash
chmod +x install.sh
./install.sh
```

### 3. Restart Terminal

Log out and back in, or restart your terminal to activate all changes.

---

## 🛠️ What Gets Installed & Configured

### System Packages (via DNF)

- **Core Tools**: `tmux`, `zsh`, `git`, `curl`, `wget`
- **Terminal Utilities**: `eza`, `bat`, `fzf`, `ripgrep`, `fd-find`
- **Development**: `neovim`, `nodejs`, `npm`, `python3-pip`
- **Media**: `xclip`, `wl-clipboard`, `figlet`
- **Optional**: `kitty`, `flatpak` support

### Configuration Files Linked

- `.zshrc` → `~/.zshrc`
- `tmux/.tmux.conf` → `~/.tmux.conf`
- `kitty/kitty.conf` → `~/.config/kitty/kitty.conf`
- `nvim/` → `~/.config/nvim/`
- `superfile/` → `~/.config/superfile/`
- `peaclock/` → `~/.config/peaclock/`

### Zsh Plugins Installed

- Oh My Zsh framework
- zsh-autosuggestions
- zsh-syntax-highlighting
- Custom aliases and functions

---

## 🛠️ Scripts & Aliases

### Available Scripts

- **System Update**: `sysup` → `~/Fedora-Linux/Scripts/update.sh`
- **Power Management**: `power-saver` → `~/Fedora-Linux/Scripts/Power-Saving.sh`
- **Hotspot Monitor**: `hotscon` → `~/Fedora-Linux/Scripts/HotspotConnections.sh`

### Useful Aliases

- `vi` → `nvim` (Neovim as default editor)
- `ls` → `eza --icons=auto` (Modern ls with icons)
- `c` → `clear` (Quick clear)
- `pokemon` → `pokemon-colorscripts -r` (Random Pokémon)
- `peaclock` → Configured peaclock with themes

---

## 🎨 Terminal & Editor Features

### Kitty Terminal

- **Theme**: Catppuccin Mocha with transparency
- **Features**: Wayland support, URL detection, cursor effects
- **Auto-tmux**: Automatically starts tmux session in Kitty

### Tmux Configuration

- **Prefix**: `Ctrl+A` (instead of default Ctrl+B)
- **Mouse Support**: Full mouse integration
- **Plugins**: TPM (Tmux Plugin Manager) ready
- **Theme**: Custom status bar with activity monitoring

### Neovim IDE Setup

- **Plugin Manager**: Lazy.nvim
- **LSP Support**: 10+ language servers (Python, TypeScript, Rust, Go, etc.)
- **Features**:
  - File explorer (Neo-tree)
  - Fuzzy finder (Telescope)
  - Git integration (Fugitive, Gitsigns)
  - Auto-completion (nvim-cmp)
  - Debugging support (nvim-dap)
  - Treesitter syntax highlighting

### Modern Tools

- **superfile**: TUI file manager with themes
- **peaclock**: Terminal clock with visual configs
- **pokemon-colorscripts**: 900+ Pokémon sprites for terminal fun

---

## 📋 System Requirements

### Minimum Requirements

- **OS**: Fedora Linux 38+
- **RAM**: 4GB (8GB+ recommended for Neovim LSP)
- **Storage**: 2GB free space
- **Display**: Any resolution (optimized for 1080p+)

### Recommended Packages

The install script will automatically install these:

```bash
# Core system tools
tmux zsh git curl wget nodejs npm python3-pip

# Terminal utilities
eza bat fzf ripgrep fd-find neovim kitty

# Development tools
gcc make cmake python3-dev nodejs-dev

# Media and clipboard
xclip wl-clipboard figlet

# Optional enhancements
flatpak snapd
```

---

## 🎯 Post-Installation

### 1. Verify Installation

```bash
# Check if everything is working
tmux -V
nvim --version
zsh --version
pokemon-colorscripts --help
```

### 2. Customize Further

- Edit `~/.zshrc` for additional aliases
- Modify `~/.tmux.conf` for tmux preferences
- Configure Neovim plugins in `~/.config/nvim/lua/plugins.lua`
- Adjust Kitty theme in `~/.config/kitty/kitty.conf`

### 3. Install Additional LSP Servers (Optional)

```bash
# Python
pip install python-lsp-server

# Node.js/TypeScript
npm install -g typescript-language-server

# Rust
rustup component add rust-analyzer
```

---

## 📸 Demo

![pokemon-colorscripts-demo](pokemon-colorscripts/demo_images/pokemon-colorscripts-demo.gif)

---

## � Troubleshooting

### Common Issues

**1. Zsh not set as default shell**

```bash
chsh -s $(which zsh)
# Log out and back in
```

**2. Tmux plugins not working**

```bash
# Install TPM first
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Then in tmux: Prefix + I to install plugins
```

**3. Neovim LSP servers not working**

```bash
# Open Neovim and run:
:checkhealth lsp
# Install missing servers as suggested
```

**4. Kitty config not loading**

```bash
# Verify Kitty is installed and config path is correct
kitty --debug-config
```

**5. Pokemon colorscripts not showing**

```bash
# Check if it's in PATH
echo $PATH | grep -q ~/.local/bin && echo "PATH OK" || echo "Add ~/.local/bin to PATH"
```

---

## 📸 Screenshots

![pokemon-colorscripts-demo](pokemon-colorscripts/demo_images/pokemon-colorscripts-demo.gif)

_More screenshots and demos available in individual tool directories_

---

## 🔄 Updates & Maintenance

### Keeping Your Setup Updated

```bash
# Update system packages
sysup

# Update dotfiles (pull latest changes)
cd ~/Fedora-Linux && git pull

# Update Neovim plugins
nvim -c "Lazy sync" -c "qa"

# Update Oh My Zsh
omz update
```

### Backup Your Configs

```bash
# The setup creates symlinks, so your configs are already in the repo
# Commit any changes you make:
cd ~/Fedora-Linux
git add -A
git commit -m "Personal customizations"
git push
```

---

## 📦 Included Tools & Versions

| Tool                     | Purpose              | Config Location        |
| ------------------------ | -------------------- | ---------------------- |
| **Zsh + Oh My Zsh**      | Shell framework      | `~/.zshrc`             |
| **Tmux**                 | Terminal multiplexer | `~/.tmux.conf`         |
| **Neovim**               | Code editor          | `~/.config/nvim/`      |
| **Kitty**                | Terminal emulator    | `~/.config/kitty/`     |
| **Superfile**            | File manager         | `~/.config/superfile/` |
| **Peaclock**             | Terminal clock       | `~/.config/peaclock/`  |
| **Pokemon Colorscripts** | Terminal art         | `~/.local/bin/`        |

---

## 📚 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Individual components have their own licenses:

- [pokemon-colorscripts](pokemon-colorscripts/LICENSE.txt) - MIT License
- Other tools follow their respective licenses

---

## 🙏 Credits & Acknowledgments

- **[pokemon-colorscripts](https://github.com/phoniks/pokemon-colorscripts)** - Terminal Pokémon art
- **[Oh My Zsh](https://ohmyz.sh/)** - Zsh framework
- **[Tmux](https://github.com/tmux/tmux)** - Terminal multiplexer
- **[Kitty](https://sw.kovidgoyal.net/kitty/)** - Modern terminal emulator
- **[Neovim](https://neovim.io/)** - Hyperextensible text editor
- **[Catppuccin](https://github.com/catppuccin)** - Beautiful pastel themes
- **[Lazy.nvim](https://github.com/folke/lazy.nvim)** - Plugin manager for Neovim

---

## 🤝 Contributing

1. Fork this repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 💖 Support

If you find this project helpful, please consider:

- ⭐ Starring this repository
- 🐛 Reporting issues
- 📝 Contributing improvements
- 📢 Sharing with others

---

**Happy hacking! 🚀**
