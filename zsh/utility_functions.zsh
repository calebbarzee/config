#!/bin/zsh

mk_cd() {
  mkdir -p "$1" && cd "$1"
}

gc_cd() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

f_cd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

open_alacritty_and_exit() {
    local dir='${1:-$(pwd)}'
    if [ -d '$dir' ]; then
        alacritty --working-directory '$dir' & disown
        exit
    else
        echo 'Error: Directory '$dir' does not exist.'
        return 1
    fi
}

git_sync() {
    local stashed=false
    if [[ -n $(git status --porcelain) ]]; then
        git stash
        stashed=true
    fi
    git pull --quiet || git pull
    if [[ "$stashed" = true ]]; then
        git stash pop
    fi
    git add -A
    git commit -m "$1"
    git push
}

github_create_private() {
    gh repo create '$1' --private --source=. --remote=origin --push
}
