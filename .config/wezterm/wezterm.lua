local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.automatically_reload_config = true
-- config.color_scheme = "OneHalfLight"
config.color_scheme = 'Solarized Light (Gogh)'
config.font = wezterm.font("JetBrains Mono", {weight="Medium", stretch="Normal", style="Normal"})
config.font_size = 14.0
config.enable_tab_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config
