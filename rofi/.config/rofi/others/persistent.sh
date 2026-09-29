#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10
## style-11    style-12    style-13    style-14    style-15

dir="$HOME/.config/rofi/theme-switcher"
theme='theme'
img="$HOME/Pictures/Backgrounds"
## Run
option=$(printf \
"1\n2\n3\n4\n5\n6\n7\n8\n9\n10" \
| rofi -dmenu -p "Persistent: ")

case "$option" in
  "1") sed -i "3c\local x = $option" ~/.config/hypr/hyprland/custom.lua;;
  "2") sed -i "3c\local x = $option" ~/.config/hypr/hyprland/custom.lua;;
  "3") sed -i "3c\local x = $option" ~/.config/hypr/hyprland/custom.lua;;
  "4") sed -i "3c\local x = $option" ~/.config/hypr/hyprland/custom.lua;;
  "5") sed -i "3c\local x = $option" ~/.config/hypr/hyprland/custom.lua;;
  "6") sed -i "3c\local x = $option" ~/.config/hypr/hyprland/custom.lua;;
  "7") sed -i "3c\local x = $option" ~/.config/hypr/hyprland/custom.lua;;
  "8") sed -i "3c\local x = $option" ~/.config/hypr/hyprland/custom.lua;;
  "9") sed -i "3c\local x = $option" ~/.config/hypr/hyprland/custom.lua;;
  "10") sed -i "3c\local x = $option" ~/.config/hypr/hyprland/custom.lua;;
esac
