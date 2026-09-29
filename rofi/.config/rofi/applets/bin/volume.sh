#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Volume

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Volume Info
speaker=$(wpctl inspect @DEFAULT_AUDIO_SINK@ | awk -F '"' '/node.description/ {print $2}')
mic=$(wpctl inspect @DEFAULT_AUDIO_SOURCE@ | awk -F '"' '/node.description/ {print $2}')

active=""
urgent=""

#Speaker Info
if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -qv '\[MUTED\]'; then
  urgent="-u 1"
  stext='Mute'
  sicon=''
else
  active="-a 1"
  stext='Unmute'
  sicon=''
fi

# Microphone Info
if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -qv '\[MUTED\]'; then
    [ -n "$active" ] && active+=",3" || active="-a 3"
    mtext='Mute'
    micon=''
else
    [ -n "$urgent" ] && urgent+=",3" || urgent="-u 3"
    mtext='Unmute'
    micon=''
fi

# Theme Elements
prompt="S:$stext, M:$mtext"
mesg="Speaker: $speaker
Mic: $mic"

	list_col='1'
	list_row='4'
	win_width='400px'

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	option_1=" Increase"
	option_2="$sicon $stext"
	option_3=" Decrese"
	option_4="$micon $mtext"
else
	option_1=""
	option_2="$sicon"
	option_3=""
	option_4="$micon"
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "Volume" \
		-mesg "$mesg" \
		${active} ${urgent} \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		wpctl set-volume @DEFAULT_AUDIO_SINK@ 20%+
	elif [[ "$1" == '--opt2' ]]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
	elif [[ "$1" == '--opt3' ]]; then
		wpctl set-volume @DEFAULT_AUDIO_SINK@ 20%-
	elif [[ "$1" == '--opt4' ]]; then
		wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
	fi
}

# Action
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
esac

