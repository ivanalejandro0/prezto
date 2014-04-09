# Add prompt dir at the start
# https://unix.stackexchange.com/questions/76505/unix-portable-way-to-get-scripts-absolute-path-in-zsh
# https://zsh.sourceforge.io/Doc/Release/Expansion.html#Modifiers
_prompt_path="${0:A:h}"
fpath=(${_prompt_path} $fpath)

# Load and execute the prompt theming system.
autoload -Uz promptinit && promptinit
# promptinit autoloads all the 'prompt_*_setup' functions in $fpath
# see https://github.com/zsh-users/zsh/blob/master/Functions/Prompts/promptinit#L22

if [[ "$TERM" == (dumb|linux|*bsd*) ]]; then
  # taken from prezto's prompt module
  prompt 'off'
else
  export VIRTUAL_ENV_DISABLE_PROMPT=1
  prompt 'ivan'
fi

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
# https://github.com/sorin-ionescu/prezto/issues/1643
setopt prompt_sp

# Remove prompt dir
fpath[(r)${_prompt_path}]=()

# Notes on removing the first occurrence of an element
# $ asdf=(a b c d c)
# $ echo $asdf
# a b c d c
# $ asdf[(r)c]=()
# $ echo $asdf
# a b d c

unset _prompt_path
