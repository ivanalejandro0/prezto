# In order to prevent the prompt to "eat" a line without CR, e.g.:
#   % echo -n foo
#   % 
# I'm adding this option to preserve any partial line, see:
# http://zsh.sourceforge.net/Doc/Release/Options.html#Prompting
# https://unix.stackexchange.com/a/22175/66916
# http://zsh.sourceforge.net/FAQ/zshfaq03.html#l40
# https://github.com/vercel/hyper/issues/2144
# https://superuser.com/q/645599/422923
# https://unix.stackexchange.com/a/167600/66916
setopt PROMPT_SP

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

# throw binaries on this folder to be accessible anywhere
export PATH="$PATH:$HOME/apps/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

if [[ "$OSTYPE" == darwin* && -x /usr/local/opt/openjdk@8/bin/java ]]; then
    # $ brew install openjdk@8
    # path update recommended by `brew info java`
    export PATH="/usr/local/opt/openjdk@8/bin:$PATH"
fi

CUSTOMIZATIONS_PATH="${ZDOTDIR:-$HOME}/.zprezto/custom/"

source "${CUSTOMIZATIONS_PATH}/fzf.zsh"
source "${CUSTOMIZATIONS_PATH}/apt.zsh"
source "${CUSTOMIZATIONS_PATH}/git.zsh"
source "${CUSTOMIZATIONS_PATH}/golang.zsh"
source "${CUSTOMIZATIONS_PATH}/nodeenvwrapper.zsh"
source "${CUSTOMIZATIONS_PATH}/fasd.zsh"
source "${CUSTOMIZATIONS_PATH}/zoxide.zsh"

source "${CUSTOMIZATIONS_PATH}/my-alias-and-functions.zsh"

# private settings, excluded from git
if [[ -f "${CUSTOMIZATIONS_PATH}/private.zsh" ]]; then
    source "${CUSTOMIZATIONS_PATH}/private.zsh"
fi
