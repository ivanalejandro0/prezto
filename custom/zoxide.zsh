if ! hash zoxide 2>/dev/null; then
    # zoxide not found
    return
fi

# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"
