#! /bin/bash

desktops=$(bspc query -D --names)
destination=$(echo $desktops | cut -d ' ' -f$1)
bspc node -d $destination -f
