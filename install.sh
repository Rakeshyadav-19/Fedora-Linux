#!/bin/bash

# ================================
# Fedora-Linux Dotfiles Installer
# ================================
# Production-ready setup script for Fedora Linux
# Installs and configures all dotfiles and development tools
# 
# Author: Rakesh Yadav
# Repository: https://github.com/Rakeshyadav-19/Fedora-Linux

set -euo pipefail  # Exit on error, undefined vars, and pipe failures

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
LOG_FILE="/tmp/fedora-linux-install.log"

# Logging function
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}" | tee -a "$LOG_FILE"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}" | tee -a "$LOG_FILE"
    exit 1
}

warning() {
    echo -e "${YELLOW}[WARNING] $1${NC}" | tee -a "$LOG_FILE"
}

info() {
    echo -e "${BLUE}[INFO] $1${NC}" | tee -a "$LOG_FILE"
}

# Check if running on Fedora
check_fedora() {
    if ! grep -qi "fedora" /etc/os-release; then
        error "This script is designed for Fedora Linux. Current OS: $(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)"
    fi
    
    local fedora_version=$(grep VERSION_ID /etc/os-release | cut -d'=' -f2 | tr -d '"')
    if [[ $fedora_version -lt 38 ]]; then
        warning "Fedora version $fedora_version detected. Recommended: 38+"
    fi
    
    log "Fedora Linux $fedora_version detected ✓"
}

# Create backup directory
create_backup() {
    log "Creating backup directory: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
    
    # Backup existing configs
    local configs=(".zshrc" ".tmux.conf" ".config/kitty" ".config/nvim" ".config/superfile" ".config/peaclock")
    
    for config in "${configs[@]}"; do
        if [[ -e "$HOME/$config" ]]; then
            info "Backing up existing $config"
            cp -r "$HOME/$config" "$BACKUP_DIR/" 2>/dev/null || true
        fi
    done
}

# Update system packages
update_system() {
    log "Updating system packages..."
    
    # Update DNF configuration for faster downloads
    sudo tee -a /etc/dnf/dnf.conf > /dev/null << 'EOF'
fastestmirror=True
max_parallel_downloads=10
defaultyes=True
keepcache=True
EOF

    sudo dnf update -yq --refresh || error "Failed to update system packages"
    log "System packages updated ✓"
}

# Install essential packages
install_packages() {
    log "Installing essential packages..."
    
    local packages=(
        # Core tools
        "git" "curl" "wget" "zsh" "tmux" "neovim"
        
        # Terminal utilities
        "eza" "bat" "fzf" "ripgrep" "fd-find" "tree"
        
        # Development tools
        "nodejs" "npm" "python3-pip" "gcc" "make" "cmake"
        
        # System utilities
        "xclip" "wl-clipboard" "figlet" "htop" "btop"
        
        # Media and graphics
        "ImageMagick" "ffmpeg"
        
        # Optional but recommended
        "kitty" "flatpak"
    )
    
    for package in "${packages[@]}"; do
        info "Installing $package..."
        if ! sudo dnf install -yq "$package" &>> "$LOG_FILE"; then
            warning "Failed to install $package, continuing..."
        fi
    done
    
    log "Package installation completed ✓"
}

# Install Flathub repository
setup_flathub() {
    log "Setting up Flathub repository..."
    
    if ! flatpak remote-list | grep -q flathub; then
        sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        log "Flathub repository added ✓"
    else
        info "Flathub already configured"
    fi
}

# Install Oh My Zsh and plugins
setup_zsh() {
    log "Setting up Zsh and Oh My Zsh..."
    
    # Install Oh My Zsh if not present
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        info "Installing Oh My Zsh..."
        RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &>> "$LOG_FILE" || error "Failed to install Oh My Zsh"
    else
        info "Oh My Zsh already installed"
    fi
    
    # Set ZSH_CUSTOM directory
    local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    
    # Install zsh-autosuggestions
    if [[ ! -d "$zsh_custom/plugins/zsh-autosuggestions" ]]; then
        info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_custom/plugins/zsh-autosuggestions" &>> "$LOG_FILE"
    fi
    
    # Install zsh-syntax-highlighting
    if [[ ! -d "$zsh_custom/plugins/zsh-syntax-highlighting" ]]; then
        info "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$zsh_custom/plugins/zsh-syntax-highlighting" &>> "$LOG_FILE"
    fi
    
    log "Zsh setup completed ✓"
}

# Set Zsh as default shell
set_default_shell() {
    local current_shell=$(getent passwd "$USER" | cut -d: -f7)
    local zsh_path=$(which zsh)
    
    if [[ "$current_shell" != "$zsh_path" ]]; then
        log "Setting Zsh as default shell..."
        if chsh -s "$zsh_path" &>> "$LOG_FILE"; then
            log "Default shell set to Zsh ✓"
            info "Please log out and back in for shell change to take effect"
        else
            warning "Failed to set Zsh as default shell. You can do it manually with: chsh -s $zsh_path"
        fi
    else
        info "Zsh is already the default shell"
    fi
}

# Install TPM for Tmux
setup_tmux() {
    log "Setting up Tmux Plugin Manager..."
    
    local tpm_dir="$HOME/.tmux/plugins/tpm"
    if [[ ! -d "$tpm_dir" ]]; then
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir" &>> "$LOG_FILE" || error "Failed to install TPM"
        log "TPM installed ✓"
        info "After setup, press Prefix + I in tmux to install plugins"
    else
        info "TPM already installed"
    fi
}

# Link configuration files
link_configs() {
    log "Linking configuration files..."
    
    # Create necessary directories
    mkdir -p "$HOME/.config/kitty"
    mkdir -p "$HOME/.config/nvim"
    mkdir -p "$HOME/.config/superfile"
    mkdir -p "$HOME/.config/peaclock"
    
    # Link .zshrc
    if [[ -f "$SCRIPT_DIR/.zshrc" ]]; then
        info "Linking .zshrc..."
        ln -sf "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
    else
        warning ".zshrc not found in $SCRIPT_DIR"
    fi
    
    # Link tmux config
    if [[ -f "$SCRIPT_DIR/tmux/.tmux.conf" ]]; then
        info "Linking .tmux.conf..."
        ln -sf "$SCRIPT_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
    else
        warning "tmux/.tmux.conf not found"
    fi
    
    # Link kitty config
    if [[ -f "$SCRIPT_DIR/kitty/kitty.conf" ]]; then
        info "Linking kitty configuration..."
        ln -sf "$SCRIPT_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
    else
        warning "kitty/kitty.conf not found"
    fi
    
    # Link nvim config
    if [[ -d "$SCRIPT_DIR/nvim" ]]; then
        info "Linking Neovim configuration..."
        ln -sf "$SCRIPT_DIR/nvim/init.lua" "$HOME/.config/nvim/init.lua"
        ln -sf "$SCRIPT_DIR/nvim/lua" "$HOME/.config/nvim/lua"
        [[ -f "$SCRIPT_DIR/nvim/lazy-lock.json" ]] && ln -sf "$SCRIPT_DIR/nvim/lazy-lock.json" "$HOME/.config/nvim/lazy-lock.json"
    else
        warning "nvim directory not found"
    fi
    
    # Link superfile config
    if [[ -d "$SCRIPT_DIR/superfile" ]]; then
        info "Linking Superfile configuration..."
        ln -sf "$SCRIPT_DIR/superfile"/* "$HOME/.config/superfile/"
    else
        warning "superfile directory not found"
    fi
    
    # Link peaclock config
    if [[ -d "$SCRIPT_DIR/peaclock" ]]; then
        info "Linking Peaclock configuration..."
        ln -sf "$SCRIPT_DIR/peaclock"/* "$HOME/.config/peaclock/"
    else
        warning "peaclock directory not found"
    fi
    
    log "Configuration files linked ✓"
}

# Make scripts executable
setup_scripts() {
    log "Setting up utility scripts..."
    
    if [[ -d "$SCRIPT_DIR/Scripts" ]]; then
        chmod +x "$SCRIPT_DIR/Scripts"/*.sh
        log "Scripts made executable ✓"
    else
        warning "Scripts directory not found"
    fi
}

# Install pokemon-colorscripts
install_pokemon_colorscripts() {
    log "Installing pokemon-colorscripts..."
    
    if [[ ! -d "$HOME/.local/bin" ]]; then
        mkdir -p "$HOME/.local/bin"
    fi
    
    if [[ -d "$SCRIPT_DIR/pokemon-colorscripts" ]] && [[ ! -d "$HOME/.local/share/pokemon-colorscripts" ]]; then
        info "Running pokemon-colorscripts installer..."
        cd "$SCRIPT_DIR/pokemon-colorscripts" || error "Failed to enter pokemon-colorscripts directory"
        
        if [[ -x "./install.sh" ]]; then
            ./install.sh &>> "$LOG_FILE" || warning "Pokemon-colorscripts installation may have failed"
            cd "$SCRIPT_DIR" || true
            log "Pokemon-colorscripts installed ✓"
        else
            warning "pokemon-colorscripts install.sh not found or not executable"
        fi
    else
        info "Pokemon-colorscripts already installed or directory not found"
    fi
}

# Install development tools and LSP servers
setup_development() {
    log "Setting up development environment..."
    
    # Python tools
    info "Installing Python development tools..."
    pip3 install --user --upgrade pip python-lsp-server black isort mypy &>> "$LOG_FILE" || warning "Some Python packages failed to install"
    
    # Node.js tools
    if command -v npm &> /dev/null; then
        info "Installing Node.js development tools..."
        npm install -g typescript-language-server bash-language-server yaml-language-server &>> "$LOG_FILE" || warning "Some npm packages failed to install"
    fi
    
    # Rust (optional)
    if ! command -v rustc &> /dev/null; then
        info "Rust not found. To install: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    fi
    
    log "Development environment setup completed ✓"
}

# Verify installation
verify_installation() {
    log "Verifying installation..."
    
    local tools=("zsh" "tmux" "nvim" "git")
    local failed_tools=()
    
    for tool in "${tools[@]}"; do
        if command -v "$tool" &> /dev/null; then
            info "$tool: ✓ $(command -v $tool)"
        else
            failed_tools+=("$tool")
        fi
    done
    
    if [[ ${#failed_tools[@]} -gt 0 ]]; then
        warning "Some tools failed to install: ${failed_tools[*]}"
    else
        log "All essential tools verified ✓"
    fi
    
    # Check if configs are linked properly
    local configs=(
        "$HOME/.zshrc"
        "$HOME/.tmux.conf"
        "$HOME/.config/kitty/kitty.conf"
        "$HOME/.config/nvim/init.lua"
    )
    
    for config in "${configs[@]}"; do
        if [[ -L "$config" ]]; then
            info "$(basename $config): ✓ linked"
        elif [[ -f "$config" ]]; then
            warning "$(basename $config): exists but not linked"
        else
            warning "$(basename $config): not found"
        fi
    done
}

# Main installation function
main() {
    # Clear screen and show banner
    clear
    echo -e "${PURPLE}"
    cat << 'EOF'
╔═══════════════════════════════════════════════════════════════════════════════╗
║                        Fedora-Linux Dotfiles Installer                       ║
║                                                                               ║
║  🚀 Setting up your development environment...                               ║
║                                                                               ║
║  Author: Rakesh Yadav                                                        ║
║  Repo: https://github.com/Rakeshyadav-19/Fedora-Linux                       ║
╚═══════════════════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}\n"
    
    log "Starting Fedora-Linux dotfiles installation..."
    log "Script directory: $SCRIPT_DIR"
    log "Log file: $LOG_FILE"
    
    # Pre-installation checks
    check_fedora
    create_backup
    
    # Core installation steps
    update_system
    install_packages
    setup_flathub
    setup_zsh
    set_default_shell
    setup_tmux
    link_configs
    setup_scripts
    install_pokemon_colorscripts
    setup_development
    
    # Post-installation verification
    verify_installation
    
    # Final message
    echo -e "\n${GREEN}════════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}🎉 Installation completed successfully!${NC}"
    echo -e "${GREEN}════════════════════════════════════════════════════════════════════════════════${NC}"
    echo
    echo -e "${CYAN}📋 Next Steps:${NC}"
    echo -e "   1. ${YELLOW}Log out and back in${NC} (or restart terminal) to activate Zsh"
    echo -e "   2. Open a new terminal to see Pokemon colorscripts in action"
    echo -e "   3. Start tmux and press ${YELLOW}Prefix + I${NC} to install tmux plugins"
    echo -e "   4. Open Neovim and run ${YELLOW}:checkhealth${NC} to verify setup"
    echo
    echo -e "${CYAN}📁 Backup created at:${NC} $BACKUP_DIR"
    echo -e "${CYAN}📝 Installation log:${NC} $LOG_FILE"
    echo
    echo -e "${CYAN}🛠️  Available commands after restart:${NC}"
    echo -e "   • ${YELLOW}sysup${NC} - System update"
    echo -e "   • ${YELLOW}pokemon${NC} - Random Pokemon"
    echo -e "   • ${YELLOW}peaclock${NC} - Terminal clock"
    echo -e "   • ${YELLOW}vi${NC} - Neovim (configured)"
    echo
    echo -e "${GREEN}Happy hacking! 🚀${NC}"
    echo
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
