# install uv, see docs
# https://docs.astral.sh/uv/getting-started/installation/#installation-methods
# curl -LsSf https://astral.sh/uv/install.sh | sh

if ! hash uv 2>/dev/null; then
    # uv not found
    return
fi
# enable completion
eval "$(uv generate-shell-completion zsh)"

if ! hash uvx 2>/dev/null; then
    # uvx not found
    return
fi
eval "$(uvx --generate-shell-completion zsh)"
