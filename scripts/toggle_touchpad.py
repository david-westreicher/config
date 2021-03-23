import subprocess

result = subprocess.check_output(["synclient", "-l"])
for line in result.decode().split("\n"):
    if "TouchpadOff" not in line:
        continue
    val = line.split("=")[-1].strip()
    break

toggle_val = "1" if val == "0" else "0"
subprocess.call(["synclient", f"TouchpadOff={toggle_val}"])
icon = "input-touchpad" if toggle_val == "1" else "input-touchpad"
text = "Touchpad Off" if toggle_val == "1" else "Touchpad On"
subprocess.call(["dunstify", "-i", icon, "-r", "503", "-u", "low", text])
