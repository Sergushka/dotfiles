-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Replace Omarchy's default SUPER+W window-close binding.
hl.unbind("SUPER + W")
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

o.bind("ALT + SHIFT + code:13", "Screenshot", "omarchy-capture-screenshot")

-- Add a second clipboard-manager shortcut (replacing the default HEY Calendar binding).
hl.unbind("SUPER + SHIFT + C")
o.bind("SUPER + SHIFT + C", "Clipboard manager", "omarchy-shell shell toggle omarchy.clipboard")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Explicitly switch the monitor between SDR and HDR.
o.bind("SUPER + ALT + H", "Toggle HDR / SDR", function()
  local monitor = hl.get_monitor("DP-1")
  if not monitor then return end
  local hdr = monitor.cm ~= "hdr" and monitor.cm ~= "hdredid"
  hl.config({ render = { cm_auto_hdr = 0 } })
  hl.monitor({
    output = "DP-1", mode = "2560x1440@239.97", position = "0x0",
    scale = 1, bitdepth = 10, cm = hdr and "hdr" or "srgb",
  })
  hl.exec_cmd("omarchy notification send -t 3000 'Display: " .. (hdr and "HDR" or "SDR") .. "'")
end)
