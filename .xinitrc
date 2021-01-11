#!/usr/bin/env bash

(redshift -r -l 0:0 -t 3000:3000) &
(sleep 15s && xset r rate 200 45) &
(~/.scripts/set_mouse_accel) &
