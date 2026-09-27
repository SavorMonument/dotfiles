# Change the default Omarchy look'n'feel

hl.config({
  general = {
    gaps_in = 1,
    gaps_out = 1
   }
})

hl.window_rule({
  match = {
      class = ".*"
  },
  opacity = "1 1"
})

hl.config({
  animations = {
    -- Disable all animations.
    enabled = false,
  },
})

o.window("org.remmina.Remmina",  {
  float = true,
  center = true,
  size = { 1000, 700 },
})

o.window("virt-manager",  {
  float = true,
  move = {"monitor_w - window_w - 50", "50"},
  size = { 500, 700 },
})

