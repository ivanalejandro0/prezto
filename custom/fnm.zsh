# https://github.com/Schniz/fnm
if ! hash fnm 2>/dev/null; then
    # fnm not found
    return
fi

# note: this already adds `fnm` to PATH
eval "$(fnm env)"

# # default install path
# FNM_DIR="/home/ivan/.local/share/fnm"
