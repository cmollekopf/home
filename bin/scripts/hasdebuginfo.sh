#!/usr/bin/env bash
#

readelf -S "$1" | grep " \(.debug_info\)\|\(.gnu_debuglink\) "

# Test whether debug information is available for a given binary
has_debug_info() {
  readelf -S "$1" | grep -q " \(.debug_info\)\|\(.gnu_debuglink\) "
}

if has_debug_info $1 ; then
    echo "Found debug info";
else
    echo "No debug info";
fi
