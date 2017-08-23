# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/home/chrigi/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

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

# alias startakonadi="systemd-cat -t "akonadi" akonadictl start"
# alias akonadilog="journalctl -n99  -f SYSLOG_IDENTIFIER=akonadi"
alias devenv='~/docker/testenv.py'

alias ackf='ack -g --color'

set -gx GOPATH "$HOME/bin/go"
set -gx PATH /usr/sbin/ $PATH "$HOME/install/bin" "$HOME/bin" "$HOME/bin/scripts" "$HOME/bin/go" "$HOME/bin/go/bin" "$HOME/.cargo/bin" "$HOME/bin/phabricator/arcanist/bin"

fish_vi_key_bindings
