#!/bin/bash
#
# func/vcsh
#
# set the context for vcs-home operations
#
# Copyright © 1994–2008 martin f. krafft <madduck@madduck.net>
# Released under the terms of the Artistic Licence 2.0
#
# Source repository: git://git.madduck.net/etc/zsh.git
#

## THIS SCRIPT IS DEPRECATED IN FAVOUR OF
## https://github.com/RichiH/vcsh

# local FGIT_BASE="$HOME/.fgits"
# 
# if [ "${1:---help}" = '--help' ] || [ $# -gt 1 ]; then
#   echo "usage: ${0##*/} reponame" >&2
#   echo "usage: ${0##*/} -l" >&2
#   [ "$1" = '--help' ]
#   return $?
# 
# elif [ "$1" = '-l' ]; then
#   for i in $FGIT_BASE/*.git; do
#     i="${i#$FGIT_BASE/}"
#     echo "${i%.git}"
#   done
#   return 0
# fi
# 
# if [ ! -d "$FGIT_BASE/${1}.git" ]; then
#   echo E: no repository found for "$1" >&2
#   return 2
# fi
# 
# old_GIT_DIR="${GIT_DIR:-}"
# old_GIT_WORK_TREE="${GIT_WORK_TREE:-}"
# 
# export GIT_DIR="$FGIT_BASE/${1}.git"
export GIT_DIR="$HOME/.dotfile/home.git"
export GIT_WORK_TREE="$GIT_DIR/$(git config --get core.worktree)"

PS1="%S{${0##*/}:$1}%s$PS1" $SHELL -i || :

GIT_DIR="$old_GIT_DIR"
[ -z "$GIT_DIR" ] && unset GIT_DIR
GIT_WORK_TREE="$old_GIT_WORK_TREE"
[ -z "$GIT_WORK_TREE" ] && unset GIT_WORK_TREE
