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
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# PATH
export N_PREFIX="$HOME/.n"
export PNPM_HOME="$HOME/Library/pnpm"
export PYENV_ROOT="$HOME/.pyenv"
export BUN_INSTALL="$HOME/.bun"
export ZIGPATH="$HOME/Code/zig/build/stage3"

path=(
    "/opt/homebrew/opt/postgresql@18/bin"
    "$N_PREFIX/bin"
    "$PNPM_HOME"
    "$PYENV_ROOT/bin"
    "$HOME/.local/bin"
    "$BUN_INSTALL/bin"
    "/opt/homebrew/opt/llvm/bin"
    "$ZIGPATH/bin"
    $path
)
export PATH

# Tool init
command -v pyenv >/dev/null && eval "$(pyenv init -)"
[ -f "/Users/cal/.ghcup/env" ] && . "/Users/cal/.ghcup/env"

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
alias lzd="lazydocker"
alias pn="pnpm"

# Puzzle mode for nvim (disables completions)
alias nvimpz="PUZZLE_MODE=1 nvim"

# Config shortcuts
alias zshcfg="nvim ~/.zshrc"
alias vimcfg="nvim ~/.config/nvim/"
alias gstcfg="nvim .config/ghostty/config"
alias theme="nvim +FormatDisable! +Lushify ~/Code/1980_sun/lua/lush_theme/1980_sun.lua"
alias dl="nvim ~/Documents/log/log_$(date +%Y_%m_%d).txt"

# Kimi via Claude CLI
cckimi() {
    export ANTHROPIC_BASE_URL=https://api.moonshot.ai/anthropic
    export ANTHROPIC_AUTH_TOKEN=${MOONSHOT_API_KEY}
    export ANTHROPIC_MODEL=kimi-k2-thinking
    export ANTHROPIC_SMALL_FAST_MODEL=kimi-k2-turbo-preview
    claude
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(starship init zsh)"
. "/Users/cal/.deno/env"
