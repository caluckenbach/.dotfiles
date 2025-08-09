# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git tmux zoxide poetry kubectl)
source $ZSH/oh-my-zsh.sh

# Environment variables
export LANG=en_US.UTF-8
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

# Tool configuration and PATH management
export N_PREFIX="$HOME/.n"
export PNPM_HOME="$HOME/Library/pnpm"
export PYENV_ROOT="$HOME/.pyenv"
export BUN_INSTALL="$HOME/.bun"
export GOPATH="$HOME/go"
export GOROOT="$(brew --prefix golang)/libexec"
export ZIGPATH="$HOME/Code/zig/build/stage3"

path=(
    "$N_PREFIX/bin"
    "$PNPM_HOME"
    "$PYENV_ROOT/bin"
    "$HOME/.local/bin"
    "$BUN_INSTALL/bin"
    "/opt/homebrew/opt/llvm/bin"
    "$GOPATH/bin"
    "$ZIGPATH/bin"
    $path
)
export PATH

# Tool initialization
command -v pyenv >/dev/null && eval "$(pyenv init -)"

# Editor configuration
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vi'
else
    export EDITOR='nvim'
fi

# ghcup
[ -f "/Users/cal/.ghcup/env" ] && . "/Users/cal/.ghcup/env"
# end ghcupt

# fabric
if [ -d "$HOME/.config/fabric/patterns" ]; then
    for pattern_file in "$HOME/.config/fabric/patterns"/*; do
        pattern_name=$(basename "$pattern_file")
        alias "$pattern_name"="fabric --pattern $pattern_name"
    done
fi

yt() {
    local video_link="$1"
    fabric -y "$video_link" --transcript
}
# fabric end

# ngrok
if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
  fi
# ngrok end

# uv
command -v uv >/dev/null && eval "$(uv generate-shell-completion zsh)"
command -v uvx >/dev/null && eval "$(uvx --generate-shell-completion zsh)"

# Fix completions for uv run to autocomplete .py files
_uv_run_mod() {
    if [[ "$words[2]" == "run" && "$words[CURRENT]" != -* ]]; then
        _arguments '*:filename:_files -g "*.py"'
    else
        _uv "$@"
    fi
}
compdef _uv_run_mod uv
# uv end

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
# yazi end


# File operation aliases
ls="eza -F --group-directories-first --color=always --icons"
la="eza -alF --group-directories-first --color=always --icons"
ll="eza -lF --group-directories-first"
lt="eza -aTF --level=2 --group-directories-first --icons --color=always"
ldot='eza -a | egrep "^\."'
alias cat="bat"
alias grep="rg"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# Git aliases
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
alias gprn="{ git fetch --all --prune && git branch -v | awk '/\[gone\]/ {print \$1}' | while read branch; do git branch -D \"\$branch\"; done; }"

# Tool shortcuts
alias lg="lazygit"
alias lzd="lazydocker"
alias pn="pnpm"

# Configuration shortcuts
alias zshcfg="nvim ~/.zshrc"
alias vimcfg="nvim ~/.config/nvim/"
alias gstcfg="nvim .config/ghostty/config"
alias theme="nvim +FormatDisable! +Lushify ~/Code/1980_sun/lua/lush_theme/1980_sun.lua"

# Daily log shortcut
alias dl="nvim ~/Documents/log/log_$(date +%Y_%m_%d).txt"

eval "$(starship init zsh)"

