local wezterm = require 'wezterm'
local os = require("os")
local io = require("io")

local config = wezterm.config_builder()

config.automatically_reload_config = true

local colorscheme = "nord" -- nord or OneHalfLight
config.color_scheme = colorscheme

local file, err = io.open(os.getenv("HOME") .. "/.colorscheme", "w")
if not file then
    print("Error: " .. err)
    os.exit(1)
end

file:write(colorscheme)
file:write("\n")
file:close()

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
