#!/bin/bash

hidden=$(bspc query -N -n .hidden.window)
nhidden=$(echo "$hidden" | wc -l)
whitelist=$(cat ~/.config/sxhkd/desktop_whitelist.txt)

if [ $nhidden -gt "0" ] && [ ! -z "$hidden" ]; then
	for i in $hidden; do
		bspc node $i --flag hidden=off
	done
else
	all=$(bspc query -N -d -n .window)
	for i in $all; do
		if [[ ! $whitelist =~ $(xtitle $i) ]]; then
			bspc node $i --flag hidden=on
		fi
	done
fi
