import math
import os
import sys

# Expects one argument with direction
assert len(sys.argv) == 2

diff = {
    'left': (-1, 0),
    'right': (1, 0),
    'up': (0, -1),
    'down': (0, 1),
}

assert sys.argv[1] in diff

d = diff[sys.argv[1]]
current = os.popen('bspc query -D -d --names').read().split('\n')
all = os.popen('bspc query -D --names').read().split('\n')
current = current[0]
all = all[:-1]
grid_size = int(math.sqrt(len(all)))
desktop_index = all.index(current)
grid_x = desktop_index % grid_size
grid_y = desktop_index // grid_size
grid_x = (grid_x + d[0]) % grid_size
grid_y = (grid_y + d[1]) % grid_size
desktop_index = grid_y * grid_size + grid_x
new = all[desktop_index]

os.system('bspc desktop -f ' + new)
