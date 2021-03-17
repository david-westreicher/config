#!/bin/python
import sys
import subprocess

minval = 1
if len(sys.argv)>1:
    change = int(sys.argv[1])
    val = int(subprocess.check_output(['cat', '/sys/class/backlight/intel_backlight/brightness']))
    maxbr = int(subprocess.check_output(['cat', '/sys/class/backlight/intel_backlight/max_brightness']))
    newval = max(minval,min(maxbr,val+change))
    subprocess.call(['sudo','/usr/local/bin/changebrightness.sh',str(newval)])
