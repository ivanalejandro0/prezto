if [[ "$OSTYPE" == darwin* ]]; then
    # we don't need this on Mac
    return
fi

if ! hash apt 2>/dev/null; then
    # apt not found
    return
fi

alias aps="apt search"
apsi(){ dpkg-query -l | rg "$1"; }
alias agi="sudo apt install"
alias agr="sudo apt-get remove --auto-remove"

# from: https://superuser.com/a/11003
# which package does a file belongs to
apbelongs(){ dpkg --search "$1" }

aplistfiles(){ dpkg --listfiles "$1" }
