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

set --export XDG_CURRENT_DESKTOP "kde"

if status --is-interactive
    keychain --eval --quiet -Q id_dsa
end

alias vim='nvim'

# alias dockercleancontainers='docker rm (docker ps -a -q)'
# alias dockerrmuntagged="docker rmi (docker images | grep "^<none>" | awk '{print $3}' ORS=' '"
# alias dockerrmuntagged="docker rmi `docker images -qf 'dangling=true'`"
# alias startakonadi="systemd-cat -t "akonadi" akonadictl start"
# alias akonadilog="journalctl -n99  -f SYSLOG_IDENTIFIER=akonadi"
alias devenv='~/docker/testenv.py'

set -gx PATH /usr/sbin/ $PATH /home/chrigi/bin
