hl.unbind("CTRL + ALT")
hl.unbind("CTRL + ALT + DELETE")
hl.unbind("SUPER + SHIFT + S")
-- hl.unbind("SUPER + RETURN")

o.bind("CTRL + ALT + HOME", "Close all windows", "omarchy-hyprland-window-close-all")
o.bind("SUPER + SHIFT + S", "Screenshot region", "omarchy screenshot")
-- o.bind("SUPER + RETURN", "New Tmux", [[
--   uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)" tmux new
-- ]])
