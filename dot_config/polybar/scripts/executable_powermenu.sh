#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

theme="~/.config/rofi/window-switcher/theme.rasi"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi"

# Options
shutdown="Shutdown\x00icon\x1fsystem-shutdown"
reboot="Restart\x00icon\x1fsystem-restart"
lock="Lock\x00icon\x1fsystem-lock-screen"
suspend="Sleep\x00icon\x1fsystem-suspend"
logout="Logout\x00icon\x1fsystem-log-out"

# Confirmation
confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "
}

# Message
msg() {
	rofi -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command \
	-p "Uptime: $uptime" -dmenu -selected-row 0 \
	-theme $theme -theme-str "window {width: 35%; height: 11%;} \
	element-icon {size: 50px;}")"
echo "Chosen: $chosen"
case $chosen in
    "Shutdown")
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			systemctl poweroff
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    "Restart")
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			systemctl reboot
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    "Lock")
		if [[ -f /usr/bin/betterlockscreen ]]; then
			betterlockscreen --lock blur
		elif [[ -f /usr/bin/i3lock ]]; then
			i3lock
		fi
        ;;
    "Sleep")
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			mpc -q pause
			amixer set Master mute
			systemctl suspend
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    "Logout")
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
				openbox --exit
			elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
				bspc quit
			elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
				i3-msg exit
			fi
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
esac
