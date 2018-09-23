#!/usr/bin/env python3

"""
focus-next-visible.py - cycles input focus between visible windows on workspace

- requires the `xprop` utility

 Usage:

    # focus next visible window
    bindsym $mod+n exec --no-startup-id focus-next-visible.py

    # focus previous visible window
    bindsym $mod+Shift+n exec --no-startup-id focus-next-visible.py reverse


https://faq.i3wm.org/question/6937/move-focus-from-tabbed-container-to-win...

"""

from sys import argv
from itertools import cycle
from subprocess import check_output

import i3ipc
import logging
logging.basicConfig(filename='/home/mollekopf/.i3/example.log',level=logging.DEBUG)

def get_windows_on_ws(conn):
    return filter(lambda x: x.window,
                  conn.get_tree().find_focused().workspace().descendents())

def find_visible_windows(windows_on_workspace):
    visible_windows = []
    for w in windows_on_workspace:
        try:
            xprop = check_output(['xprop', '-id', str(w.window)]).decode()
        except FileNotFoundError:
            logging.debug("File not found" + str(w.window))
            raise SystemExit("The `xprop` utility is not found!"
                             " Please install it and retry.")
        except:
            logging.debug("Going down" + str(w.window))

        # if '_NET_WM_STATE_HIDDEN' not in xprop:
        #     continue
        if '_NET_WM_WINDOW_TYPE_UTILITY' in xprop:
            logging.debug("Skipping" + str(w.window))
            continue

        logging.debug("Not skippint" + str(w.window))
        visible_windows.append(w)

    return visible_windows


if __name__ == '__main__':

    logging.debug("------")
    conn = i3ipc.Connection()

    visible_windows = find_visible_windows(get_windows_on_ws(conn))

    if len(argv) > 1 and argv[1] == "reverse":
        cycle_windows = cycle(reversed(visible_windows))
    else:
        cycle_windows = cycle(visible_windows)

    logging.debug("windows" + str(cycle_windows))

    for window in cycle_windows:
        if window.focused:
            focus_to = next(cycle_windows)
            logging.debug("focus_to" + str(focus_to.window))
            conn.command('[id="%d"] focus' % focus_to.window)
            break

