#!/usr/bin/env bash

shopt -s nullglob globstar
list="gen"
selection=$(boom $list | rofi -lines 8 -dmenu -p "boom" | cut -d':' -f1 | sed 's/ *//g')
printf '%s' "$(boom echo $list "$selection")" | head -1 | wl-copy
