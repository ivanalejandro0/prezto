if ! hash fnm 2>/dev/null; then
    # fnm not found
    return
fi

# https://github.com/Schniz/fnm
eval "$(fnm env)"
