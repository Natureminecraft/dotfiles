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

files=()
for file in "$img"/*; do
    # Check if entry exists to handle empty directories correctly
    if [ -e "$file" ]; then
        files+=("$(basename "$file")")
    fi
done

all_file=$(printf "%s\n" "${files[@]}")
option=$(printf \
  "%s\n" "${files[@]}"\
| rofi -dmenu -p "Themes: ")

awww img $img/$option --transition-type grow
