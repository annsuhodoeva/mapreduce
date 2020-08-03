#!/usr/bin/python3

from collections import Counter
import sys
import numpy as np
import pandas as pd
from scipy.sparse import lil_matrix

m = pd.read_csv('movies.txt', header=None, index_col=0)[1]
s = pd.read_csv('sim.txt', header=None).rename(columns={0:'i', 1:'j', 2:'r'})

ind = np.union1d(np.unique(s['i']), np.unique(s['j']))
rev_ind = pd.Series(np.arange(len(ind)), index=ind)
ii = rev_ind[s['i']]
jj = rev_ind[s['j']]

sim = lil_matrix((len(ind), len(ind)))
sim[ii, jj] = s['r']
sim[jj, ii] = s['r']

current_word = None
for line in sys.stdin:
    user, film, mark = line.strip().split()
    mark = float(mark)
    film = int(film) 
    if current_word == user:
        a[film] = mark
    else:
        if current_word:
            mov = rev_ind[np.array(list(a.keys()), dtype=int)].values
            rl = np.array(list(a.values()), dtype=float)
            
            mat = sim[:, mov]
            z = np.setdiff1d(np.unique(mat.nonzero()[0]), mov)
            if len(z) != 0:
                mat = mat[z,:].toarray()
                res = (mat * rl).sum(axis=1) / mat.sum(axis=1)
                array = list(zip(res, m[ind[z]].values))

                array = sorted(sorted(array, reverse=False, key=lambda x: x[1]), key=lambda x: x[0], reverse=True)
                print('%s:%s,%s,%s' % (current_word, array[0][1], array[1][1], array[2][1]))
        current_word = user
        a = Counter()
        a[film] = mark
    
if current_word == user:
    mov = rev_ind[np.array(list(a.keys()), dtype=int)].values
    rl = np.array(list(a.values()), dtype=float)
    mat = sim[:, mov]
    z = np.setdiff1d(np.unique(mat.nonzero()[0]), mov)
    if len(z) != 0:
        mat = mat[z,:].toarray()
        res = (mat * rl).sum(axis=1) / mat.sum(axis=1)
        array = list(zip(res, m[ind[z]].values))

        array = sorted(sorted(array, reverse=False, key=lambda x: x[1]), key=lambda x: x[0], reverse=True)
        print('%s:%s,%s,%s' % (current_word, array[0][1], array[1][1], array[2][1]))