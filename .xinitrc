#!/usr/bin/env bash

(/usr/bin/redshift -r -l 0:0 -t 3000:3000) &
(/usr/bin/sleep 15s && /usr/bin/xset r rate 200 45) &

if [ -f $HOME/.scripts/set_mouse_accel ]; then
    ($HOME/.scripts/set_mouse_accel) &
fi

