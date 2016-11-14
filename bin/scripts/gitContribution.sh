#!/bin/bash
git log --shortstat --author "$1" --since "2 years ago" --until "1 week ago" \
    | grep "files\? changed" \
    | awk '{files+=$1; inserted+=$4; deleted+=$6} END \
           {print "files changed", files, "lines inserted:", inserted, "lines deleted:", deleted}'
