# Disable greeting
set fish_greeting

# make Vim the default editor
set --export EDITOR "nvim -f"

# make Vim usable with git
set --export GIT_EDITOR "nvim -f"

# use Vim as default pager
# set --export PAGER "vimpager"
set --export PAGER

# make Vim usable with hg
set --export HGEDITOR "nvim -f"


if status --is-interactive
    keychain --eval --quiet -Q id_dsa
end

alias vim='nvim'
alias notes='nvim ~/notes/stuff'

# alias startakonadi="systemd-cat -t "akonadi" akonadictl start"
# alias akonadilog="journalctl -n99  -f SYSLOG_IDENTIFIER=akonadi"
alias devenv='~/docker/testenv.py'

alias ackf='ack -g --color'

set -gx GOPATH "$HOME/bin/go"
set -gx PATH /usr/sbin/ $PATH "$HOME/install/bin" "$HOME/bin" "$HOME/bin/scripts" "$HOME/bin/go" "$HOME/bin/go/bin" "$HOME/.cargo/bin" "$HOME/bin/phabricator/arcanist/bin"


#Fixes a neovim issue (among others opening commits from gblame): https://github.com/junegunn/fzf/issues/881
function fish_vi_cursor; end
function __fish_cursor1337; end
fish_vi_key_bindings

set -U FZF_LEGACY_KEYBINDINGS 0
