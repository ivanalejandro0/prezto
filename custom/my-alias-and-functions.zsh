psg() {
    ps aux | grep -v grep | egrep --color=auto --ignore-case --regexp="$@|COMMAND"
}

# finame() { find . -iname "*$1*"; }  # no longer needed, I use fd now
mkcd() { mkdir ${1}; cd ${1}  }

alias pingo="ping -4 www.google.com"
# alias shred="shred -fuvz"
alias serve.py="python3 -m http.server"
alias tmux="tmux -2"

mdf() {
  # custom (my)df, only shows /, logs results to file
  local LOG_FILE="$HOME/df.log"
  touch $LOG_FILE
  date --iso-8601=seconds >> $LOG_FILE
  df -h / | tee --append $LOG_FILE
  echo >> $LOG_FILE
}

now() {
  # custom date+time function, localized for Argentina
  LC_ALL=es_AR.UTF-8 date +"%A, %d de %B de %Y - %I:%M %p"
}

if hash gls 2>/dev/null; then
    # GNU coreutils alias for OSX
    # `brew install coreutils`
    alias ls="gls --group-directories-first --color=always -F -b"
    alias df="gdf"
else
    alias ls="ls --group-directories-first --color=always -F -b"
fi

# For date/string formatting options see:
# run-help fc
# man zshmisc
# man strftime
alias hist='fc -rl -t "%Y/%b/%d %H:%M" 1 | fzf -n2..,.. --scheme=history'
