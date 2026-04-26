# bun completions
[ -s "/home/ivan/.bun/_bun" ] && source "/home/ivan/.bun/_bun"

# bun
BUN_INSTALL="$HOME/.bun"
BUN_BIN="$BUN_INSTALL/bin"

if [[ ! -d $BUN_BIN ]]; then
  return
fi

pathadd $BUN_BIN
export BUN_INSTALL
