#中心極限定理（t分布）
import numpy as np
import matplotlib.pyplot as plt
"""
import sys
 
args = sys.argv
argc = len(args)
if argc != 2:
    print('ERROR:Input_DOF.')
    quit()
"""
Y = []
y = 0
c = 0
n = 1000
for k in range(3):
    for l in range (5000):
        for i in range(n):
            for j in range(2):
                x = np.random.randn()
                c += x*x
            z = np.random.randn()
            y += z / np.sqrt(c/2) 
        Y.append(y / (1 / np.sqrt(n)))  
        c = 0
        y = 0
    plt.hist(Y, bins = 100)
    #plt.show()
    plt.savefig('tcenter_' + str(k + 1) + '.png')
    plt.clf()
    Y.clear()
