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

# fix to get back color to man pages
# see:
# https://github.com/jedsoft/most/issues/9#issuecomment-2558517596
# https://bbs.archlinux.org/viewtopic.php?id=287185
export MANROFFOPT=-c

# if [[ ${(t)path} =~ "unique" ]]; then
#   # Uniqueness check not needed when `typeset -gU path`
#   typeset -gU path
# fi
#
# if [[ ${(t)fpath} =~ "unique" ]]; then
#   # Uniqueness check not needed when `typeset -gU path`
#   typeset -gU fpath
# fi

# Ensure path arrays do not contain duplicates.
typeset -gU fpath path

# Note: function accessible globally
# Prepend $1 to the $path array, if $1 exists
pathadd() {
  if [[ -d "$1" ]]; then
    path=($1 $path)
  fi
}

# Note: function accessible globally
# Prepend $1 to the $fpath array, if $1 exists
fpathadd() {
  if [[ -d "$1" ]]; then
    fpath=($1 $fpath)
  fi
}

# throw binaries on this folder to be accessible anywhere
pathadd "$HOME/apps/bin"

# default on many systems, or added by installers like uv
pathadd "$HOME/.local/bin"

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
source "${CUSTOMIZATIONS_PATH}/pnpm.zsh"
source "${CUSTOMIZATIONS_PATH}/prompt/init.zsh"
source "${CUSTOMIZATIONS_PATH}/rust.zsh"
# source "${CUSTOMIZATIONS_PATH}/uv.zsh"  # commented out because it slows down the startup
source "${CUSTOMIZATIONS_PATH}/yarn.zsh"
source "${CUSTOMIZATIONS_PATH}/zoxide.zsh"

source "${CUSTOMIZATIONS_PATH}/coreutils-mac.zsh"
source "${CUSTOMIZATIONS_PATH}/my-alias-and-functions.zsh"

# private settings, excluded from git
if [[ -f "${CUSTOMIZATIONS_PATH}/private.zsh" ]]; then
    source "${CUSTOMIZATIONS_PATH}/private.zsh"
fi
