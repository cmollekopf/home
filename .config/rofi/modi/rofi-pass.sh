#!/usr/bin/env bash

shopt -s nullglob globstar
prefix=${PASSWORD_STORE_DIR-$HOME/.password-store}
password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )
selection=$(printf '%s\n' "${password_files[@]}" | rofi -lines 8 -dmenu -p "gopass")
printf '%s' "$(pass "$selection")" | head -1 | wl-copy
