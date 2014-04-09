# Git helpers, aliases and functions

# I have disabled all the gazillion aliases from 'git' module that comes with
# Prezto, and copied whatever I use here.
# Disabled 'git' module on `zprestorc`

alias gg="git grep"

# Git Current Branch
alias gcb="git symbolic-ref --short HEAD"

# Git Current Upstream (get the remote name of the branch we are tracking)
# from: https://stackoverflow.com/a/9753364/687989
# alternative:
# alias gcu="git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD)"
alias gcu='git rev-parse --abbrev-ref --symbolic-full-name "@{u}"'

function gl() {
    # format from from https://github.com/sorin-ionescu/prezto/blob/master/modules/git/alias.zsh
    local _git_log_medium_format='%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B'
    git log --topo-order --pretty=format:"${_git_log_medium_format}" $@
}

function gt() {
    # List tags sorted by create date
    # from: https://stackoverflow.com/a/6270112
    git for-each-ref --sort=creatordate --format '%(refname:short) - %(creatordate) - %(creatordate:relative)' refs/tags
}

# show git branches sorted by recent activity
gblast() {
    local _git_last_branch_format="%(HEAD) %(refname:short);%(objectname:short);[%(color:blue)%(upstream:short)%(color:reset)] %(contents:subject) (%(color:cyan)%(committerdate:relative)%(color:reset))"
    git for-each-ref --sort=committerdate refs/heads/ --format="${_git_last_branch_format}" --color=always | column -s ';' -t
}

gblastR() {
    local _git_last_branch_format="%(HEAD) %(refname:short);%(objectname:short) %(contents:subject) (%(color:cyan)%(committerdate:relative)%(color:reset))"
    git branch --remotes --sort=committerdate --format="${_git_last_branch_format}" --color=always | column -s ';' -t
}

if ! hash fzf 2>/dev/null; then
    # fzf not found
    return
fi

gblastf() {
    # git checkout `gblastf`
    gblast | \
        fzf \
        --ansi \
        --tac \
        --tiebreak=index \
        --no-hscroll \
        --preview="echo branch:  {1}; echo message: {3..}; echo commit:  {2}" \
        --preview-window="down:4:wrap" \
        --bind='ctrl-u:half-page-up,ctrl-d:half-page-down' | \
        sed -e 's/^\*/ /' | cut -f3 -d' '
    }

gblastfR() {
    # git checkout `gblastfR`
    local out=$(
    gblastR | \
    fzf \
        --ansi \
        --tac \
        --tiebreak=index \
        --no-hscroll \
        --preview="echo branch:  {1}; echo message: {3..}; echo commit:  {2}" \
        --preview-window="down:4:wrap" \
        --bind='ctrl-u:half-page-up,ctrl-d:half-page-down'
    )
    local branch=$(echo $out | awk '{ print $1 }')

    [ -z $branch ] && return
    echo "$branch"
}

gco() {
    local branch=$(gblastf)
    [ ! -z $branch ] && git checkout $branch
}

gcoR() {
    local branch=$(gblastfR)
    [ ! -z $branch ] && git checkout --track $branch
}

gsl() {
    local items=$(git stash list)
    fzf \
        --height='50%' \
        --reverse \
        --prompt='stash> ' \
        --delimiter=":" \
        --preview='git stash show --color -p {1}' \
        <<< "$items"
}
