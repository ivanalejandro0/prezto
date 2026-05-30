function _prompt_ivan_format_time() {
  local -i time_in_ms=$1

  local -i d_s=$(( time_in_ms / 1000 ))
  local -i ms=$(( time_in_ms % 1000 ))
  local -i s=$(( d_s % 60 ))
  local -i m=$(( (d_s / 60) % 60 ))
  local -i h=$(( d_s / 3600 ))

  if (( h > 0 )); then
    print -r -- "${h}h${m}m${s}s"

  elif (( m > 0 )); then
    print -r -- "${m}m${s}.$(( ms / 100 ))s"

  elif (( s > 9 )); then
    print -r -- "${s}.$(( ms / 10 ))s"

  elif (( s > 0 )); then
    print -r -- "${s}.${(l:3::0:)ms}s"

  else
    print -r -- "${ms}ms"
  fi
}
