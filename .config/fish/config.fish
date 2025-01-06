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


alias vim='nvim'
alias notes='nvim ~/data/notes/stuff'
alias todo='nvim ~/data/notes/todo'
alias ls='eza'
alias extract='dtrx'
alias rscp="rsync -avzP"
alias arcdiff="arc diff --allow-untracked --verbatim --browse HEAD^"
alias arcup="arc diff HEAD^ --update"
alias arcrebase="git rebase -i --exec 'arc diff --allow-untracked --verbatim HEAD^' "
alias arcpatch="arc patch --nobranch"
alias ag="ag -f -F --"

# alias startakonadi="systemd-cat -t "akonadi" akonadictl start"
# alias akonadilog="journalctl -n99  -f SYSLOG_IDENTIFIER=akonadi"

alias ackf='ack -g --color'

set -g theme_short_path yes
set -g fish_color_command normal
set -g fish_color_comment red

#Fixes a neovim issue (among others opening commits from gblame): https://github.com/junegunn/fzf/issues/881
function fish_vi_cursor; end
function __fish_cursor1337; end
fish_vi_key_bindings

# Workaround because I can't figure out where this is set from (it doesn't work under tmux, but does otherwise?)
set -g SSH_AUTH_SOCK /run/user/1000/gnupg/S.gpg-agent.ssh

fish_add_path ~/bin/scripts/

fish_add_path ~/bin/ ~/bin/scripts/ ~/.attuin/bin/
# if status --is-interactive; and not set -q TMUX
#     tmux attach -t default; or tmux new -s default
# end
if status --is-interactive
    if which kubectl 2> /dev/null;
        kubectl completion fish | source
    end
    kictl completion fish | source
    #kolabctl completion fish | source
    atuin init fish | source
end
