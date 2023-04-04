#!/bin/python3
import subprocess

max_brightness = int(subprocess.check_output(["brightnessctl", "m"]))
cur_brightness = int(subprocess.check_output(["brightnessctl", "g"]))
brightness_percent = int(100 * cur_brightness / max_brightness)

print(brightness_percent)
cmd = [
    "dunstify",
    "-u", "low",
    "-i","/usr/share/icons/Papirus-Dark/16x16/actions/lighttable.svg",
    "Brightness",
    "-h", f"int:value:{brightness_percent}",
    "-h", "string:x-dunst-stack-tag:brightness",
    "-a", "brightness_change"
]
subprocess.call(cmd)
