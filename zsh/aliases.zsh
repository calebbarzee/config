#!/bin/zsh

alias zed='zed .'
# terminal open (override macOS native terminal open)
alias alacritty='open_alacritty_and_exit'
# python (default to python 3)
alias py='python3'
alias pip='pip3'
alias py_venv='python3 -m venv .venv && source .venv/bin/activate'
# homebrew
alias brew_arm_i='arch -arm64 brew install'
alias brew_arm_ri='arch -arm64 brew reinstall'
# ai tools
alias huggin='huggingface-cli'
# docker
alias doc='docker'
alias doc_comp='docker-compose'
alias d_build_v_nc='BUILDKIT_PROGRESS=plain docker buildx build --no-cache'
alias d_build_v='BUILDKIT_PROGRESS=plain docker buildx build'
# git
alias git_s='git status'
alias git_i='git fetch --all && git status && echo "\nlog:" && git log --oneline --graph --decorate --all -n 10 && echo "\ndiff:" && git diff --stat HEAD@{1} HEAD'
alias git_p='git pull'
alias git_pu='git push'
alias git_branches='git fetch --all && git branch -a'
# unix CLI customize
alias ..='cd ..'
alias ...='cd ../..'
alias f='fzf'
alias grep='rg --hidden'
alias ls='pwd; ls -lah --color=auto'
# CLI utilities
alias tree='tree -a -I ".DS_Store|.git|node_modules|*.log"'
