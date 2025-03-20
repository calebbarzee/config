#!/bin/zsh

# TODO: remove this it's dumb
# terminal open (override macOS native terminal open)
if [[ "$(uname)" == "Darwin" ]]; then
    alias alacritty='open_alacritty_and_exit'
fi
# homebrew
if [[ "$(uname)" == "Darwin" ]]; then
    alias brew_arm_i='arch -arm64 brew install'
    alias brew_arm_ri='arch -arm64 brew reinstall'
fi
# python (default to python 3)
alias py='python3'
alias pip='pip3'
alias py_venv='python3 -m venv .python && source .python/bin/activate'
# ai tools
alias huggin='huggingface-cli'
# docker
alias d='docker'
alias dc='docker-compose'
alias db='docker build'
alias db_c='docker build --no-cache'
alias db_v='BUILDKIT_PROGRESS=plain docker build'
alias db_v_c='BUILDKIT_PROGRESS=plain docker build --no-cache'
# git
alias g='git'
alias gs='git fetch --all && git status'
alias gst='git status' # to remind me there's an alias, but better to use git s for fetch first
alias gi='git_info'
alias gl='git log --oneline --graph --decorate -n 20'
alias gd='git diff'
alias gfd='git_file_diff_10'
alias gp='git pull'
alias gpl='git pull'
alias gpsh='git push'
alias gb='git fetch --all && git branch -ra' # view all branches
alias gbr='git checkout -b' # create a new branch and switch to it
alias gx='git checkout'
alias gc='git commit' # commit with a provided message
alias gcm='git commit -m' # commit with a provided message
alias ga='git add'
alias gr='git restore'
# TODO: re-evaluate if git reset --soft is actually what I want here
alias gu='git reset --soft' # unstage the current changes and reset to HEAD
alias gsy='git_sync' # TODO: revise function, go away from git commit -i, also maybe just move to lazy git TUI
alias gh_c='git_create_private' # creates a private github repository
# unix CLI customize
alias mkcd='mkdir_and_cd'
alias gccd='git_clone_and_cd'
alias fcd='find_and_cd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cd='z'
alias fm='yazi' # yazi - terminal file manager
alias find='fzf' # fuzzy find
alias grep='rg --hidden' # ripgrep - search hidden files
alias ls='pwd; ls -lah --color=auto' # ls - display all items and properties
# CLI utilities
alias tree='tree -a -I ".DS_Store|.git|node_modules|*.log|build|*cache|.next"'
if lsb_release -a 2>/dev/null | grep -q "Ubuntu"; then
    alias bat='batcat'
fi
alias man='() { man "$@" | bat; }'
alias cat='bat'
