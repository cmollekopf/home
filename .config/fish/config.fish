# Disable greeting
set fish_greeting

# make Vim the default editor
set --export EDITOR "nvim -f"

# make Vim usable with git
set --export GIT_EDITOR "nvim -f"

# use Vim as default pager
# set --export PAGER "vimpager"
set --export PAGER "less"

# make Vim usable with hg
set --export HGEDITOR "nvim -f"

#Set TERM to something that also other systems understand (otherwise ssh breaks)
set --export TERM "screen-256color"

if status --is-interactive
    keychain --eval --quiet -Q id_dsa
    keychain --eval --quiet -Q id_ed25519
end

alias vim='nvim'
alias notes='nvim ~/notes/stuff'
alias todo='nvim ~/notes/todo'
alias ls='exa'

# alias startakonadi="systemd-cat -t "akonadi" akonadictl start"
# alias akonadilog="journalctl -n99  -f SYSLOG_IDENTIFIER=akonadi"
alias devenv='~/docker/testenv.py'

alias ackf='ack -g --color'

set -gx GOPATH "$HOME/bin/go"
set -gx PATH $PATH "$HOME/.local/share/flatpak/exports/bin/" "$HOME/bin" "$HOME/bin/scripts" "$HOME/bin/go" "$HOME/bin/go/bin" "$HOME/.cargo/bin" "$HOME/bin/arcanist/bin"

set -gx CPATH "$HOME/.nix-profile/include"
set -gx LIBRARY_PATH "$HOME/.nix-profile/lib"
set -gx QTDIR "$HOME/.nix-profile"

set -g theme_short_path yes
set -g fish_color_command normal

#Fixes a neovim issue (among others opening commits from gblame): https://github.com/junegunn/fzf/issues/881
function fish_vi_cursor; end
function __fish_cursor1337; end
fish_vi_key_bindings

set -U FZF_LEGACY_KEYBINDINGS 0

if status --is-interactive; and not set -q TMUX
    tmux attach -t default; or tmux new -s default
end
