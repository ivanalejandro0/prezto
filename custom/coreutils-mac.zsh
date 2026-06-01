if [[ "$OSTYPE" != darwin* ]]; then
  # We only need this on Mac,
  return
fi

if ! hash gls 2>/dev/null; then
  # no coreutils, exit
  # GNU coreutils installed with: `brew install coreutils`
  return
fi

# $ brew info coreutils
# ...
# ==> Caveats
# Commands also provided by macOS and the commands dir, dircolors, vdir have been installed with the prefix "g".
# If you need to use these commands with their normal names, you can add a "gnubin" directory to your PATH with:
#   PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# from older `brew info coreutils` but still relevant:
#
# Additionally, you can access their man pages with normal names if you add
# the "gnuman" directory to your MANPATH from your bashrc as well:
#
#     MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# alias ls="gls"  # already defined on ./my-alias-and-functions.zsh
alias df="gdf"
alias date="gdate"
