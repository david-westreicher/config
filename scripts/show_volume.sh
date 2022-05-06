function get_volume {
    pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume:/ { print $5 }' | cut -d '%' -f 1
}

volume=`get_volume`
muted=`pactl get-sink-mute @DEFAULT_SINK@ | awk '/Mute:/ { print $2 }'`
bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')
icon=$([[ "$muted" == "yes" ]] && echo "audio-volume-muted" || echo "audio-volume-high")
dunstify -i $icon -r 502 -u low $bar
