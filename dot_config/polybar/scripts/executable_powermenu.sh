#!/usr/bin/env bash

theme="~/.config/rofi/window-switcher/theme.rasi"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi"

# Options
shutdown="Shutdown\x00icon\x1fsystem-shutdown"
reboot="Restart\x00icon\x1fsystem-restart"
lock="Lock\x00icon\x1fsystem-lock-screen"
suspend="Sleep\x00icon\x1fsystem-suspend"
logout="Logout\x00icon\x1fsystem-log-out"

# Variable passed to rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command \
	-p "Uptime: $uptime" -dmenu -selected-row 0 \
	-theme $theme -theme-str "window {width: 35%; height: 11%;} \
	element-icon {size: 50px;}")"

echo "Chosen: $chosen"

case $chosen in
	"Shutdown")
		systemctl poweroff
		;;
	"Restart")
		systemctl reboot
		;;
	"Lock")
		if [[ -f /usr/bin/betterlockscreen ]]; then
			betterlockscreen --lock blur
		elif [[ -f /usr/bin/i3lock ]]; then
			i3lock
		fi
		;;
	"Sleep")
		mpc -q pause
		amixer set Master mute
		systemctl suspend
		;;
	"Logout")
		if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
			openbox --exit
		elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
			bspc quit
		elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
			i3-msg exit
		fi
		;;
esac
