#!/bin/bash
id=$(bspc query -N -n)
info=$(xwininfo -id $id)
upper_left_x=$(echo "$info" | grep "Absolute upper-left X" | awk '{print $4}')
upper_left_y=$(echo "$info" | grep "Absolute upper-left Y" | awk '{print $4}')
width=$(echo "$info" | grep "Width" | awk '{print $2}')
height=$(echo "$info" | grep "Height" | awk '{print $2}')
bottom_right_x=$((upper_left_x + width))
bottom_right_y=$((upper_left_y + height))
echo "$upper_left_x $upper_left_y $bottom_right_x $bottom_right_y"
