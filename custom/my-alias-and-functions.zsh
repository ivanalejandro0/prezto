psg() {
    ps aux | grep -v grep | egrep --color=auto --ignore-case --regexp="$@|COMMAND"
}

# finame() { find . -iname "*$1*"; }  # no longer needed, I use fd now
mkcd() { mkdir ${1}; cd ${1}  }

alias pingo="ping www.google.com"
alias shred="shred -fuvz"
alias serve.py="python3 -m http.server"
alias tmux="tmux -2"


if hash gls 2>/dev/null; then
    # GNU coreutils alias for OSX
    # `brew install coreutils`
    alias ls="gls --group-directories-first --color=always -F -b"
    alias df="gdf"
else
    alias ls="ls --group-directories-first --color=always -F -b"
fi

alias hist='fc -rl -t "%d/%m/%y %H:%M" 1 | fzf -n2..,.. --tiebreak=index'
