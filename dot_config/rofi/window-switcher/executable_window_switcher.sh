#!/usr/bin/env bash
path=$HOME/.config/rofi/window-switcher/theme.rasi

options="-kb-accept-entry "!Alt_L,!Alt-Tab,!Alt+Alt_L" \
	-kb-row-down "Alt+Tab" -selected-row 1"

function set_dimensions {
	echo "-theme-str 'window {width: $1%; height: $2%;}'"
}

no_of_window=$(bspc query -N -d -n .window | wc -l)

echo "Number of windows: $no_of_window"
echo "Dimensions: " $(set_dimensions 10 10)

width=$(($no_of_window * 10))
width=$(($width > 70 ? 70 : $width))
height=15

echo "Width: $width, Height: $height"

cmd="rofi -no-lazy-grab -show windowcd -icon-theme "Papirus" \
	-theme $path $(set_dimensions $width $height) $options &"
echo $cmd
eval $cmd
