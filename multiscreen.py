import subprocess
import curses
import signal
import sys

stdscr = curses.initscr()
def exit():
    curses.nocbreak(); stdscr.keypad(0); curses.echo()
    curses.endwin()
def signal_handler(signal, frame):
    exit()
    sys.exit(0)
signal.signal(signal.SIGINT, signal_handler)

connectedOutputs = []
def updateInfo():
    connectedOutputs[:] = []
    xrandrout = subprocess.Popen(['xrandr'],stdout=subprocess.PIPE).communicate()[0]
    for line in xrandrout.split('\n'):
        if 'connected' in line:
            impinfo = line.split('(')[0]
            output = impinfo.split(' ')[0]
            connected = not 'disconnected' in impinfo and 'mm' in line
            rotation = 'left' if 'left' in impinfo else ('right' if 'right' in impinfo else 'normal')
            connectedOutputs.append({'name':output, 'connected':connected,'rotation':rotation})
updateInfo()

curses.noecho()
curses.cbreak()
stdscr.keypad(1)

selected = 0
move = -1
def draw():
    stdscr.addstr('%-15s\t'*4 % ('','name','connected','rotation') + '\n')
    for i,output in enumerate(connectedOutputs):
        marker = ' '*6
        if i==selected: marker += '*' if move == -1 else 'm'
        stdscr.addstr('%-15s\t'*4 % (marker,output['name'],output['connected'],output['rotation']) + '\n')

def rotate(output):
    rotations = ['left','right','normal']
    name = output['name']
    rot = rotations.index(output['rotation'])
    rot = rotations[(rot+1)%len(rotations)]
    output['rotation'] = rot
def onoff(output):
    name = output['name']
    connected = output['connected']
    output['connected'] = not connected

def executeXRANDR():
    cmd = ['xrandr']
    lastoutput = None
    for output in connectedOutputs:
        cmd.append('--output')
        cmd.append(output['name'])
        if not output['connected']:
            cmd.append('--off')
            continue
        cmd.append('--auto')
        cmd.append('--rotate')
        cmd.append(output['rotation'])
        if lastoutput is not None:
            cmd.append('--right-of')
            cmd.append(lastoutput['name'])
        lastoutput = output
    stdscr.addstr(str(cmd)+'\n')
    subprocess.call(cmd)
def swap(indx1,indx2):
    tmp = connectedOutputs[indx1]
    connectedOutputs[indx1] = connectedOutputs[indx2]
    connectedOutputs[indx2] = tmp

while 1:
    stdscr.clear()
    draw()
    stdscr.refresh()
    c = stdscr.getch()
    if c == 27 or c == ord('q'):
        break
    if c == ord('o'):
        onoff(connectedOutputs[selected])
        executeXRANDR()
        #updateInfo()
    if c == ord('r'):
        rotate(connectedOutputs[selected])
        executeXRANDR()
        #updateInfo()
    if c == ord('m'):
        if move<0: move=selected
        else: move = -1
    if c == curses.KEY_DOWN:
        selected+=1
    if c == curses.KEY_UP:
        selected-=1
    selected = min(len(connectedOutputs)-1,max(0,selected))
    if move>=0:
        swap(move,selected)
        move = selected
        executeXRANDR()
exit()
