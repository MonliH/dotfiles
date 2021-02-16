#!/bin/bash

# Terminate already running bar instances
killall -q xmobar

# Wait until the processes have been shut down
while pgrep -u $UID -x xmobar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/xmobar/xmobarrc
xmobar /home/jonathan/.config/xmobar/xmobarrc.hs
