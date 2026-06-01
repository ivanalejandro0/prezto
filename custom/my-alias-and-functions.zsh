psg() {
    ps aux | grep -v grep | egrep --color=auto --ignore-case --regexp="$@|COMMAND"
}

# finame() { find . -iname "*$1*"; }  # no longer needed, I use fd now
mkcd() { mkdir ${1}; cd ${1}  }

# alias pingo="ping -4 www.google.com"
pingo() {
  if [[ "$OSTYPE" == darwin* ]]; then
    # on mac, `ping` defaults to ipv4
    ping www.google.com
    return
  fi

  # on some cases, linux defaults to ipv6, use ipv4 explicitly
  ping -4 www.google.com
}

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
  # for some reason, %p/%P is empty for es_AR
  # on Linux, on Mac seems to work, maybe there's an issue with a coreutils version
  # LC_ALL=es_AR.UTF-8 date +"%p"
  LC_ALL=es_AR.UTF-8 date +"%A, %d de %B de %Y - %I:%M $(date +%P)"
}

if [[ "$OSTYPE" == linux* ]]; then
  alias ls="ls --group-directories-first --color=always -F -b"
elif [[ "$OSTYPE" == darwin* ]]; then
  # default mac `ls` doesn't have `--group-directories-first`
  alias ls="ls --color=always -F -b"

  if hash gls 2>/dev/null; then
    # if ls from GNU coreutils is available use it
    # installed on mac with `brew install coreutils`
    alias ls="gls --group-directories-first --color=always -F -b"
  fi
fi

# For date/string formatting options see:
# run-help fc
# man zshmisc
# man strftime
alias hist='fc -rl -t "%Y/%b/%d %H:%M" 1 | fzf -n2..,.. --scheme=history'
