#!/usr/bin/python3

from collections import Counter
import sys
import numpy as np

current_word = None
bc = Counter()
for line in sys.stdin:
    user, film, mark = line.strip().split()
    try:
        mark = float(mark)
    except ValueError:
        continue
    if current_word == user:
        bc[film] = mark
    else:
        if current_word:
            r_ = np.mean(list(bc.values()))
            for i, r_i in bc.items():
                a = round(r_i - r_, 5)
                for j, r_j in bc.items():
                    if i < j:
                        b = round(r_j - r_, 5)
                        print('%s,%s\t%s %s' % (i, j, str(a), str(b)))
        current_word = user
        bc = Counter()
        bc[film] = mark
    
if current_word == user:
    r_ = np.mean(list(bc.values()))
    for i, r_i in bc.items():
        a = round(r_i - r_, 5)
        for j, r_j in bc.items():
            if i < j:
                b = round(r_j - r_, 5)
                print('%s,%s\t%s %s' % (i, j, str(a), str(b)))
