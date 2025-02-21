#!/bin/zsh

alias zed='open_zed'
# terminal open (override macOS native terminal open)
alias alacritty='open_alacritty_and_exit'
# python (default to python 3)
alias py='python3'
alias pip='pip3'
alias py_venv='python3 -m venv .python && source .python/bin/activate'
# homebrew
alias brew_arm_i='arch -arm64 brew install'
alias brew_arm_ri='arch -arm64 brew reinstall'
# ai tools
alias huggin='huggingface-cli'
# docker
alias d='docker'
alias d_comp='docker-compose'
alias d_build_v_nc='BUILDKIT_PROGRESS=plain docker buildx build --no-cache'
alias d_build_v='BUILDKIT_PROGRESS=plain docker buildx build'
# git
alias g_s='git fetch --all && git status'
alias g_st='git status' # to remind me there's an alias, but better to use g_s for fetch first
alias g_i='git_info'
alias g_fd='git_file_diff_10'
alias g_p='git pull'
alias g_pu='git push'
alias g_brs='git fetch --all && git branch -a'
alias g_x='git checkout'
alias g_br='git checkout -b'
alias g_c='git commit -m' # commit with a provided message
alias g_a='git add'
alias g_u='git reset --soft' # unstage the current changes and reset to HEAD
alias g_sy='git_sync'
alias gh_c='git_create_private'
# unix CLI customize
alias mkcd='mkdir_and_cd'
alias gccd='git_clone_and_cd'
alias fcd='find_and_cd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cd='z'
alias fm='yazi' # yazi - terminal file manager
alias f='fzf' # fuzzy find
alias grep='rg --hidden' # ripgrep - search hidden files
alias ls='pwd; ls -lah --color=auto' # ls - display all items and properties
# CLI utilities
alias tree='tree -a -I ".DS_Store|.git|node_modules|*.log|build|*cache"'