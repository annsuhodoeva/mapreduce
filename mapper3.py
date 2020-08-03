#!/usr/bin/python3

import sys

for line in sys.stdin:
    w = line.strip().split(',')
    print('%s\t%s %s' % (w[0], w[1], w[2]))


