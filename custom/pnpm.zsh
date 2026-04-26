if ! hash pnpm 2>/dev/null; then
    # pnpm not found
    return
fi

# This is added to support pnpm global installs
# Even if npm globals are managed and separated with fnm, pnpm globals are
# managed separately
PNPM_HOME=$HOME/.local/share/pnpm

if [[ ! -d $PNPM_HOME ]]; then
  return
fi

pathadd $PNPM_HOME
export PNPM_HOME
