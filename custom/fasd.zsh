if ! hash fasd 2>/dev/null; then
    # fasd not found
    return
fi

# https://github.com/clvv/fasd
eval "$(fasd --init auto)"

# simple cd-fzf
cdf_() {
  local dir
  dir="$(fasd -Rdl "$1" | fzf --reverse --height "40%" -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

# simple cd-fzf, more clear/detailed implementation
cdf() {
    local filter="$1"
    local items=$(fasd -Rdl "${filter}")

    local dir=$(
    fzf \
        --height "40%" \
        --reverse \
        --no-sort \
        --no-multi \
        --select-1 \
        --exit-0 \
        <<< "$items"
    )
    cd "${dir}" || return 1
}

# cd-fzf with preview
cdf2() {
    local filter="$1"
    local items=$(fasd -Rdl "${filter}")

    local LS=$(alias ls | cut -d "'" -f2)
    # LS="$LS -lsh"

    local dir=$(
    fzf \
        --no-sort \
        --no-multi \
        --select-1 \
        --exit-0 \
        --preview "$LS {}" \
        <<< "$items"
    )
    cd "${dir}" || return 1
}

