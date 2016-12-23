#!/bin/python
import sys
import subprocess

minval = 0
if len(sys.argv)>1:
    change = int(sys.argv[1])
    val = int(subprocess.check_output(['cat', '/sys/class/leds/asus::kbd_backlight/brightness']))
    maxbr = int(subprocess.check_output(['cat', '/sys/class/leds/asus::kbd_backlight/max_brightness']))
    if val==maxbr:
        newval = minval
    else:
        newval = max(minval,min(maxbr,val+change))
    subprocess.call(['sudo','/usr/local/bin/changekbbrightness.sh',str(newval)])
