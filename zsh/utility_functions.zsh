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

read_Yn() {
    local prompt="$1"
    local response
    while true; do
        read "response?$prompt (Y/n): "
        case $response in
            [yY]|"") return 0 ;;
            [nN]) return 1 ;;
            *) echo "Please enter y/Y/Enter for yes, or n/N for no" ;;
        esac
    done
}

git_sync() {
    local stashed=false
    local commit_msg="$1"
    local current_branch=$(git branch --show-current)

    if [[ -z $(git status --porcelain) ]] && [[ -z $(git log "origin/$current_branch..$current_branch") ]]; then
        git pull
        git status
        return 0
    fi

    if [[ -n $(git status --porcelain) ]]; then
        git stash
        stashed=true
    fi

    echo -e "\nOn branch: $current_branch"
    if ! read_Yn "Is this the correct branch?"; then
        [[ "$stashed" = true ]] && git stash pop
        return 1
    fi

    git pull --quiet || git pull

    if [[ "$stashed" = true ]]; then
        git stash pop
    fi

    echo -e "\nChanges to be committed:"
    git status --short

    if [[ -z "$commit_msg" ]]; then
        read "commit_msg?Please enter a commit message: "
    fi

    echo -e "\nCommit message: $commit_msg"
    if ! read_Yn "Do you want to proceed?"; then
        return 1
    fi

    git add -A
    git commit -m "$commit_msg"
    git push
}

github_create_private() {
    gh repo create '$1' --private --source=. --remote=origin --push
}
