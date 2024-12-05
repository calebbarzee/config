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
