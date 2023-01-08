#!/bin/bash

# TODO: detect bspwm
id=$(~/scripts/bspwm_id.sh)
echo "Window id = $id"

if [ "$id" == "-1" ]; then
	# Start widget and configure it
	python ~/scripts/widget.py &
	while [ "$id" == "-1" ]; do
		id=$(~/scripts/bspwm_id.sh)
		sleep 0.1
	done
	echo "Window id again = $id"
	bspc node $id -l below -t floating
else
	# Delete window
	bspc node "$id" -c
fi
