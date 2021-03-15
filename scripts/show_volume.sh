function get_volume {
    pacmd list-sinks | awk '/\tvolume:/ { print $5 }' | tail -n+$((sink_nr+1)) | head -n1 | cut -d '%' -f 1
}

volume=`get_volume`
bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')
dunstify -r 502 -u low $bar
