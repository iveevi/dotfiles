#!/bin/sh

# Get all connected monitors
monitors=$(xrandr --query | grep " connected" | cut -d " " -f 1)

# Configure monitors
initialize_cmd="xrandr --output "
previous_monitor=""
primary=0

for monitor in $monitors; do
	# resolution=$(xrandr --query | grep $monitor -A 1 | tail -n 1 | cut -d " " -f 4)
	resolution="2560x1440"
	echo "Monitor: " $monitor ", resolution: " $resolution

	# Append to the xrandr command
	if [ $primary -eq 0 ]; then
		initialize_cmd="$initialize_cmd $monitor --primary --mode $resolution --rotate normal"
		primary=1
	else
		initialize_cmd="$initialize_cmd --output $monitor --mode $resolution --rotate normal --right-of $previous_monitor"
	fi

	previous_monitor=$monitor
done

echo "Command: " $initialize_cmd
sh -c "$initialize_cmd"

# Priority naming for desktops
priority_names="browser games notes development"
priority_count=0
priority_max=$(echo $priority_names | wc -w)

echo "Priority names: " $priority_names ", max: " $priority_max

# Configure desktops
desktop_count=0
desktops_per_monitor=4

for monitor in $monitors; do
	desktop_string=""
	for i in $(seq 1 $desktops_per_monitor); do
		if [ $priority_count -lt $priority_max ]; then
			priority_count=$((priority_count+1))
			desktop_name=$(echo $priority_names | cut -d " " -f $priority_count)
		else
			desktop_count=$((desktop_count+1))
			desktop_name="extra-$desktop_count"
		fi
		desktop_string="$desktop_string $desktop_name"
	done

	echo "Desktops: " $desktop_string
	bspc monitor $monitor -d $desktop_string
done
