BAT=$(upower -e | grep -E 'battery_BAT|BAT0' | head -n1)
CAPACITY=$(upower -i "$BAT" | awk '/percentage/ {gsub("%",""); print $2}')
STATE=$(upower -i "$BAT" | awk '/state/ {print $2}')

ICONS_DEFAULT=("󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
ICONS_CHARGING=("󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅")

INDEX=$(( CAPACITY / 10 ))
(( INDEX > 10 )) && INDEX=10

if [[ "$STATE" == "charging" ]]; then
    ICON="${ICONS_CHARGING[$INDEX]}"
else
    ICON="${ICONS_DEFAULT[$INDEX]}"
fi

# --- Power plan via TuneD ---
if command -v tuned-adm >/dev/null 2>&1; then
    POWERPLAN=$(tuned-adm active 2>/dev/null | sed -n 's/^Current active profile: //p')
    [[ -z "$POWERPLAN" ]] && POWERPLAN="tuned: unable to read profile"
else
    POWERPLAN="tuned-adm not found"
fi

CLASS="normal"
if [[ "$STATE" == "charging" ]]; then
    CLASS="charging"
elif (( CAPACITY <= 15 )); then
    CLASS="critical"
elif (( CAPACITY <= 30 )); then
    CLASS="warning"
fi

printf '{"text": "%s  %s%%", "tooltip": "%s", "class": "%s", "percentage": %s}\n' \
  "$ICON" "$CAPACITY" "$POWERPLAN" "$CLASS" "$CAPACITY"
