#!/bin/zsh

mkdir_and_cd() {
  mkdir -p "$1" && cd "$1"
}

git_clone_and_cd() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

find_and_cd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

pathify() {
    local target="$1"
    # absolute path provided
    if [[ "$target" = /* ]]; then
        echo "$target"
    # relative path provided
    else
        echo "$(pwd)/${target}"
    fi
}

open_zed() {
    zed "$(pathify "${1:-$(pwd)}")"
}

open_alacritty_and_exit() {
    local dir="${1:-$(pwd)}"
    if [ -d "$dir" ]; then
        alacritty --working-directory "$dir" & disown
        exit
    else
        echo 'Error: Directory "$dir" does not exist.'
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
            *) echo 'Please enter y/Y/Enter for yes, or n/N for no' ;;
        esac
    done
}

git_sync() {
    local stashed=false
    local commit_msg="$1"
    local current_branch=$(git branch --show-current)

    if [[ -z $(git status --porcelain) ]] && [[ -z $(git log "origin/$current_branch..$current_branch" 2>/dev/null) ]]; then
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
        # in the future add another path here to allow user to switch to current branch when branch is wrong
        # and continue the commit
        return 1
    fi

    git pull --quiet || git pull

    if [[ "$stashed" = true ]]; then
        git stash pop
    fi

    echo -e "\nPlease choose what to add:"
    git add -i

    if [[ -z "$commit_msg" ]]; then
        read "commit_msg?Please enter a commit message: "
    fi

    echo -e "\nCommit message: $commit_msg"
    if ! read_Yn "Do you want to proceed?"; then
        return 1
    fi

    git commit -m "$commit_msg"
    git push
}

git_info() {
    git fetch --all
    git status
    git rev-parse --abbrev-ref HEAD
    # ^ display branch name
    PAGER='' git log --oneline --graph --decorate -n 10
    # ^ show recent commits and prevent paging (could also pipe to cat or less)
    PAGER='' git diff --stat HEAD@{1} HEAD
    # ^ show file changes and prevent paging
}

git_info_related() {
    # place holder for fuction to show changes in related or affected branches
    # alias g_i='git fetch --all
    # git status
    # echo "\nBranch Info:"
    # git rev-parse --abbrev-ref HEAD
    # echo "\nLog (current branch):"
    # git log --oneline --graph --decorate -n 10
    # echo "\nRelated branches:"
    # git log --oneline --graph --decorate --branches -n 5
    # echo "\nDiff from previous state:"
    # git diff --stat HEAD@{1} HEAD | cat'
}

git_file_diff_10() {
    if [ -z "$1" ]; then
        echo "Usage: file_diff <filename> [number_of_commits]"
        # ^ tell the user they need to supply a file name
        return 1
    fi

    num_commits=${2:-10}
    # ^ default to 10 commits prior if not specified

    old_commit=$(git rev-list HEAD -n $num_commits | tail -n 1)
    # ^ get the necessary commit hash

    echo -e "\nShowing changes to $1 over last $num_commits commits:"
    PAGER='' git diff $old_commit..HEAD "$1"
}

github_create_private() {
    gh repo create '$1' --private --source=. --remote=origin --push
}
