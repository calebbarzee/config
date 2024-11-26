eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/bin/alacritty:$PATH"
export PATH="/opt/homebrew/opt/go/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

open_alacritty_and_exit() {
    local dir="${1:-$(pwd)}"
    if [ -d "$dir" ]; then
        alacritty --working-directory "$dir" & disown
        exit
    else
        echo "Error: Directory '$dir' does not exist."
        return 1
    fi
}

alias py="python3"
alias pip="pip3"
alias brew_i="arch -arm64 brew install"
alias huggin="huggingface-cli"
alias ls="pwd; ls -lah --color=auto"
alias tree="tree -a -I '.DS_Store|.git|node_modules|*.log'"
alias alacritty="open_alacritty_and_exit"
alias d_build_v_nc="BUILDKIT_PROGRESS=plain docker buildx build --no-cache"
alias d_build_v="BUILDKIT_PROGRESS=plain docker buildx build"
alias git_changes='git fetch --all && git status && echo "\nlog:" && git log --oneline --graph --decorate --all -n 10 && echo "\ndiff:" && git diff --stat HEAD@{1} HEAD'

# config dir redirect
export XDG_CONFIG_HOME=$HOME/.config

# work config
export GOPRIVATE="github.com/Trident-Sensing/*"

# starhip init
eval "$(starship init zsh)"
