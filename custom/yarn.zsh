if [[ ! -d "$HOME/.yarn" ]]; then
    # yarn not found
    return
fi

pathadd "$HOME/.yarn/bin"
