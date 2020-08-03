#!/usr/bin/python3

import sys
from math import sqrt

current_word = None
s1, s2, s3 = 0., 0., 0.
for line in sys.stdin:
    w = line.strip().split()
    f, a, b = w[0],w[1],w[2]
    if current_word == f:
        s1 += float(a)**2
        s2 += float(b)**2
        s3 += float(a)*float(b)
    else:
        if current_word:
            if s1 * s2 != 0:
                s = s3 / (sqrt(s1) * sqrt(s2))
            else:
                s = 0
            if s > 0:
                print('%s,%s' % (current_word, str(min(round(s, 6), 1))))
        s1 = float(a)**2
        s2 = float(b)**2
        s3 = float(a)*float(b)
        current_word = f

if current_word == f:
    if s1 * s2 != 0:
        s = s3 / (sqrt(s1) * sqrt(s2))
    else:
        s = 0
    if s > 0:
        print('%s,%s' % (current_word, str(min(round(s, 6), 1))))

    