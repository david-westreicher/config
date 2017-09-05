import sys
import curses
import signal
import subprocess

def get_torrents(search):
    import requests
    endpoint = 'https://torrentapi.org/pubapi_v2.php'
    r = requests.get(endpoint, params={'get_token':'get_token'})
    token = r.json()['token']
    r = requests.get(endpoint, params={'mode':'search','search_string':' '.join(sys.argv[1:]),'token':token})
    data = r.json()
    if not 'error' in data:
        for torrent in data['torrent_results']:
            print torrent['filename']
            print torrent['download']
            print ''
        return data['torrent_results']
    else:
        print 'Nothing found'
        return []

torrents = get_torrents(' '.join(sys.argv[1:]))

stdscr = curses.initscr()
def exit():
    curses.nocbreak(); stdscr.keypad(0); curses.echo()
    curses.endwin()
def signal_handler(signal, frame):
    exit()
    sys.exit(0)
signal.signal(signal.SIGINT, signal_handler)

curses.noecho()
curses.cbreak()
stdscr.keypad(1)

selected = 0

def draw():
    for i,t in enumerate(torrents):
        marker = ' '*6
        if i==selected: marker += '*'
        stdscr.addstr('%-15s\t'*2 % (marker,t['filename']) + '\n')

while 1:
    stdscr.clear()
    draw()
    stdscr.refresh()
    c = stdscr.getch()
    if c == 27 or c == ord('q'):
        break
    if c in [ord('j'), curses.KEY_DOWN]:
        selected+=1
    if c in [ord('k'), curses.KEY_UP]:
        selected-=1
    if c in [ord('o'),10]:
        subprocess.Popen(['xdg-open', torrents[selected]['download']])
        exit()
        sys.exit(0)
    selected = min(len(torrents),max(0,selected))
exit()
