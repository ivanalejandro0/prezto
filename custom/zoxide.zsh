if ! hash zoxide 2>/dev/null; then
    # zoxide not found
    return
fi

export _ZO_FZF_OPTS="
    --height 40% \
    --min-height 30 \
    -n2..,.. \
    --reverse \
    --bind=ctrl-z:ignore \
    --no-multi \
    --no-sort \
    --preview-window='down:3:wrap' \
    --bind 'ctrl-/:toggle-preview' \
    --preview='echo -e Score: {1} \\\nPath: {2}' \
    --no-hscroll \
"

# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

alias zqi="zoxide query --interactive"

# # zoxide query --interactive + directory contents preview
# cdf() {
#     local filter="$1"
#     local items=$(zoxide query --list "${filter}")
#
#     local LS=$(alias ls | cut -d "'" -f2)
#     # LS="$LS -lsh"
#
#     local dir=$(
#     fzf \
#       --reverse \
#         --no-sort \
#         --no-multi \
#         --select-1 \
#         --exit-0 \
#         --preview "$LS {}" \
#         --bind 'ctrl-/:toggle-preview' \
#         <<< "$items"
#     )
#     cd "${dir}" || return 1
# }
#
