if [[ ! -f "$HOME/.cargo/env" ]]; then
    return
fi

# originally put on runcoms/zshenv by Rust installer
source "$HOME/.cargo/env"
