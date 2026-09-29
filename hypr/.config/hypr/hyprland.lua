-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")
require("~/.config/hypr/hyprland/custom.lua")
require("~/.config/hypr/hyprland/keymaps.lua")
require("~/.config/hypr/hyprland/decorate.lua")
require("~/.config/hypr/hyprland/window-rules.lua")
require("~/.config/hypr/hyprland/monitors.lua")
-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd(
    "pkill xdg-desktop-portal-hyprland ; pkill xdg-desktop-portal ; /usr/lib/polkit-kde-authentication-agent-1 & /usr/lib/xdg-desktop-portal-hyprland && /usr/lib/xdg-desktop-portal")
  hl.exec_cmd("XDG_MENU_PREFIX,arch-")
  hl.exec_cmd("xhost +local:root")
  hl.exec_cmd("pkill waybar; waybar")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("swaync")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("HYPRCURSOR_THEME", "macOS")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "macOS")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRSHOT_DIR", "/home/nature/Pictures/Screenshots")
