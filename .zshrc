# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export GEMINI_API_KEY="AIzaSyBq-qvTE7RRHd4jvev83jvhitXMl3zvSLY"
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="clean"

# Automatically start tmux if not already inside a tmux session
# if command -v tmux >/dev/null 2>&1; then
#   [ -z "$TMUX" ] && [ -n "$PS1" ] && exec tmux
# fi

# Auto-attach to a tmux session if not already inside tmux, and only in Kitty
if [[ -n "$KITTY_WINDOW_ID" ]] && command -v tmux >/dev/null 2>&1; then
  if [ -z "$TMUX" ]; then
    (tmux attach-session -t main || tmux new-session -s main)
    # After tmux exits, close Kitty
    if [[ -n "$KITTY_WINDOW_ID" ]]; then
      kitty @ close-window --self
    fi
  fi
fi
#Custom script for pokemon
pokemon-colorscripts -r

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(zsh-autosuggestions zsh-syntax-highlighting)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"


source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#COMMANDS
alias vi="nvim"
alias ls='eza --icons=auto' # short list
alias c='clear'
alias lscreated='ls --sort=created'
alias pokemon='pokemon-colorscripts -r'

#APPS
alias vdow='yt-dlp'
alias qrg='qrcode-terminal'
alias fdow='aria2c -x 16 -s 16'
alias iopen='eog'
alias iedit='display'
alias peaclock="peaclock --config-dir ~/.config/peaclock"
alias re="~ && c && source ~/.zshrc"
alias cls="c && source ~/.zshrc"
#SCRIPTS
alias sysup='~/./Fedora-Linux/Scripts/update.sh'
alias hotscon='~/./Fedora-Linux/Scripts/HotspotConnections.sh'
alias power-saver='~/Fedora-Linux/Scripts/Power-Saving.sh'

#Directories
alias clg='cd /home/rax/Abyss/B-Tech/All Sems'
export PATH="${HOME}/.local/bin":${PATH}
