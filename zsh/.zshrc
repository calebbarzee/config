#!/bin/zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/bin/alacritty:$PATH"
export PATH="/opt/homebrew/opt/go/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# config dir redirect
export XDG_CONFIG_HOME=$HOME/.config

# work config
export GOPRIVATE='github.com/Trident-Sensing/*'
#brew services start black # start up python formatter

source ~/.config/zsh/utility_functions.zsh
# utility functions get sourced first since some aliases shorten these functions
source ~/.config/zsh/aliases.zsh

source $HOME/.cargo/env

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"

source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-you-should-use/you-should-use.plugin.zsh
