# Configurations for FZF
# https://github.com/junegunn/fzf

# if `fd` is available use it
# https://github.com/sharkdp/fd
if hash fd 2>/dev/null; then
    export FZF_CTRL_T_COMMAND='fd --type file'
    export FZF_ALT_C_COMMAND='fd --type directory'
fi

# if ripgrep is available use it
# https://github.com/BurntSushi/ripgrep
# if hash rg 2>/dev/null; then
#     export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
# fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
