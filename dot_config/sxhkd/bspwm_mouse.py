import os
import sys
import subprocess

from pynput import mouse

# Cache position
px, py = 0, 0
first = True

# Get mode: move or resize
assert len(sys.argv) == 2
mode = sys.argv[1]

cmd = -1
if mode == 'move':
    cmd = 1
elif mode == 'resize':
    cmd = 2

    # Get window bottom right
    out = subprocess.check_output('/home/venki/.config/sxhkd/get_extent.sh') \
        .decode('utf-8').strip()

    split = out.split(' ')
    brx, bry = int(split[2]), int(split[3])

    # Move to bottom right corner
    mouse.Controller().position = (brx, bry)
else:
    print('Unknown mode')
    sys.exit(1)

def on_move(x, y):
    global px, py, first, cmd

    if first:
        px, py = x, y
        first = False
        return

    dx, dy = x - px, y - py
    px, py = x, y

    if cmd == 1:
        subprocess.call(['bspc', 'node', '-v', str(dx), str(dy)])
    elif cmd == 2:
        print('dx: {}, dy: {}'.format(dx, dy))
        subprocess.call(['bspc', 'node', '-z', 'bottom_right', str(dx), str(dy)])

def on_click(x, y, button, pressed):
    if not pressed:
        return False

# Collect events until released
with mouse.Listener(on_move=on_move, on_click=on_click) as listener:
    listener.join()
