#!/bin/zsh
    
if [[ "$(uname)" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="/opt/homebrew/bin/alacritty:$PATH"
    export PATH="/opt/homebrew/opt/go/bin:$PATH"
    export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
        
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /opt/homebrew/share/zsh-you-should-use/you-should-use.plugin.zsh
fi

# config dir redirect
export XDG_CONFIG_HOME=$HOME/.config

# work config
export GOPRIVATE='github.com/Trident-Sensing/*'

# TODO: fix this
# zsh case-insensitive completions
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# git completions
autoload -Uz compinit && compinit

# utility functions get sourced first since some aliases shorten these functions
source ~/.config/zsh/utility_functions.zsh
source ~/.config/zsh/aliases.zsh

source $HOME/.cargo/env

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"

source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

