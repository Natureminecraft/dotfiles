#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Battery

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"
profile=$(tuned-adm active | awk '{print $NF}')

# Battery Info
battery="`acpi -b | cut -d',' -f1 | cut -d':' -f1`"
status="`acpi -b | cut -d',' -f1 | cut -d':' -f2 | tr -d ' '`"
percentage="`acpi -b | cut -d',' -f2 | tr -d ' ',\%`"
time="`acpi -b | cut -d',' -f3`"

if [[ -z "$time" ]]; then
	time=' Fully Charged'
fi

# Theme Elements
prompt="$status"
mesg="Current: ${profile}"

	list_col='1'
	list_row='4'
	win_width='400px'

# Charging Status
active=""
urgent=""
if [[ $status = *"Charging"* ]]; then
    active="-a 1"
    ICON_CHRG=""
elif [[ $status = *"Full"* ]]; then
    active="1"
    ICON_CHRG=""
else
    urgent="1"
    ICON_CHRG=""
fi

# Discharging
if [[ $percentage -ge 5 ]] && [[ $percentage -le 19 ]]; then
    ICON_DISCHRG=""
elif [[ $percentage -ge 20 ]] && [[ $percentage -le 39 ]]; then
    ICON_DISCHRG=""
elif [[ $percentage -ge 40 ]] && [[ $percentage -le 59 ]]; then
    ICON_DISCHRG=""
elif [[ $percentage -ge 60 ]] && [[ $percentage -le 79 ]]; then
    ICON_DISCHRG=""
elif [[ $percentage -ge 80 ]] && [[ $percentage -le 100 ]]; then
    ICON_DISCHRG=""
fi

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	option_1="Performance"
	option_2="Balance"
	option_3="Power saver"
  option_4="Return"
else
	option_1="Performance"
	option_2="Balance"
	option_3="Power saver"
  option_4="Return"
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str "textbox-prompt-colon {str: \"$ICON_DISCHRG\";}" \
		-dmenu \
		-p "$prompt" \
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
	polkit_cmd="pkexec env PATH=$PATH DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY"
	if [[ "$1" == '--opt1' ]]; then
		tuned-adm profile throughput-performance && pkill -RTMIN+8 waybar 
  elif [[ "$1" == '--opt2' ]]; then
    tuned-adm profile balanced && pkill -RTMIN+8 waybar
	elif [[ "$1" == '--opt3' ]]; then
    tuned-adm profile powersave && pkill -RTMIN+8 waybar
	elif [[ "$1" == '--opt4' ]]; then
   pkill rofi ; ~/.config/rofi/applets/bin/battery.sh
  fi
}

# Actions
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


