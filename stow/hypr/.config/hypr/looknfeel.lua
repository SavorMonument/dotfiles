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
