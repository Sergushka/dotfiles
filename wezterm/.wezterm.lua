local wezterm = require("wezterm")

local config = {}


config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 14

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.color_scheme = 'Catppuccin Mocha'
config.keys = {
    {key="v", mods="CTRL", action=wezterm.action{PasteFrom="Clipboard"}},
}

if os.getenv("XDG_CURRENT_DESKTOP") == "Hyprland" then
  config.enable_wayland = false
else
  config.enable_wayland = true
end

return config
