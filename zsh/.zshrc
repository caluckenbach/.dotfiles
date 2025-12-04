# Deno completions
if [[ ":$FPATH:" != *":/Users/cal/.zsh/completions:"* ]]; then export FPATH="/Users/cal/.zsh/completions:$FPATH"; fi

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git tmux zoxide poetry kubectl)
source $ZSH/oh-my-zsh.sh

# History
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY HIST_REDUCE_BLANKS

# Environment
export LANG=en_US.UTF-8

if [[ -d "/opt/homebrew" ]]; then
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_ENV_HINTS=1
fi

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# PATH
typeset -U path # Ensure unique entries automatically
local path_candidates=(
    "$HOME/.cargo/bin"
    "$BUN_INSTALL/bin"
    "$N_PREFIX/bin"
    "$PYENV_ROOT/bin"
    "$HOME/.local/bin"
    "$ZIGPATH/bin"
)

# Only append if directory exists
for p in "${path_candidates[@]}"; do
    [[ -d "$p" ]] && path+=("$p")
done
export PATH

# Tool init
command -v pyenv >/dev/null && eval "$(pyenv init -)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"

# Editor
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vi'
else
    export EDITOR='nvim'
fi

# uv completions
command -v uv >/dev/null && eval "$(uv generate-shell-completion zsh)"
command -v uvx >/dev/null && eval "$(uvx --generate-shell-completion zsh)"
_uv_run_mod() {
    if [[ "$words[2]" == "run" && "$words[CURRENT]" != -* ]]; then
        _arguments '*:filename:_files -g "*.py"'
    else
        _uv "$@"
    fi
}
compdef _uv_run_mod uv

# yazi (cd to dir on exit)
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# File operations
unalias ls la ll lt ldot 2>/dev/null
ls() { eza -F --group-directories-first --color=always --icons "$@" }
la() { eza -alF --group-directories-first --color=always --icons "$@" }
ll() { eza -lF --group-directories-first "$@" }
lt() { eza -aTF --level=2 --group-directories-first --icons --color=always "$@" }
ldot() { eza -a | rg "^\." }
alias cat="bat"
alias grep="rg"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# Git
alias g="git"
alias gp="git push"
alias gpf="git push --force"
alias gpl="g pull"
alias gpls="g pull --recurse-submodules"
alias gst="git stash"
alias gstp="git stash pop"
alias gs="git switch"
alias gsc="git switch -c"
alias gco="git checkout"
alias grb="git rebase"
alias gcan="git commit --amend --no-edit"
alias gsh="git show --ext-diff"
alias gl="git log -p --ext-diff"
gprn() {
    git fetch --all --prune
    git branch -v | awk '/\[gone\]/ {print $1}' | while read branch; do
        git branch -D "$branch"
    done
}

# Tools
alias lg="lazygit"

# Puzzle mode for nvim (disables completions)
alias nvimpz="PUZZLE_MODE=1 nvim"

alias dl="nvim ~/Documents/log/log_$(date +%Y_%m_%d).txt"

# Kimi via Claude CLI
cckimi() {
    export ANTHROPIC_BASE_URL=https://api.moonshot.ai/anthropic
    export ANTHROPIC_AUTH_TOKEN=${MOONSHOT_API_KEY}
    export ANTHROPIC_MODEL=kimi-k2-thinking
    export ANTHROPIC_SMALL_FAST_MODEL=kimi-k2-turbo-preview
    claude
}

eval "$(starship init zsh)"
