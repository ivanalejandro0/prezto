# NOTE: this is to avoid a 'set locale failed' warning using git
# thanks to: http://appsjagan.blogspot.com.ar/2012/11/perl-warning-falling-back-to-standard.html
# look also: http://codetheory.in/fixing-locale-warnings-notices-issues-on-linux-server-or-desktop/
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# # export LC_ALL=es_AR.UTF-8
# export LANGUAGE=en_US.UTF-8

# use neovim as command line editor (C-x C-e)
export EDITOR=`which nvim`
export VISUAL=`which nvim`

# vim/tmux/osx tweak (for Ctrl+h to work)
export TERMINFO="$HOME/.terminfo"

# Note: function accessible globally
pathadd() {
  # Add parameter to PATH only if it exists and if it's not already added
  # When running zsh -> tmux -> zsh some paths gets added twice if we just
  # export PATH="$1:$PATH"
  # from: https://superuser.com/a/39995
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

# throw binaries on this folder to be accessible anywhere
pathadd "$HOME/apps/bin"

# export PATH="$PATH:$HOME/.local/bin"  # Default on system

CUSTOMIZATIONS_PATH="${ZDOTDIR:-$HOME}/.zprezto/custom/"

# TODO: maybe load everything on this path instead of listing them one by one?
source "${CUSTOMIZATIONS_PATH}/apt.zsh"
source "${CUSTOMIZATIONS_PATH}/bun.zsh"
source "${CUSTOMIZATIONS_PATH}/deno.zsh"
source "${CUSTOMIZATIONS_PATH}/fnm.zsh"
source "${CUSTOMIZATIONS_PATH}/fzf.zsh"
source "${CUSTOMIZATIONS_PATH}/git.zsh"
source "${CUSTOMIZATIONS_PATH}/golang.zsh"
source "${CUSTOMIZATIONS_PATH}/openjdk-mac.zsh"
source "${CUSTOMIZATIONS_PATH}/prompt/init.zsh"
source "${CUSTOMIZATIONS_PATH}/rust.zsh"
source "${CUSTOMIZATIONS_PATH}/yarn.zsh"
source "${CUSTOMIZATIONS_PATH}/zoxide.zsh"

source "${CUSTOMIZATIONS_PATH}/my-alias-and-functions.zsh"

# private settings, excluded from git
if [[ -f "${CUSTOMIZATIONS_PATH}/private.zsh" ]]; then
    source "${CUSTOMIZATIONS_PATH}/private.zsh"
fi
