#大数の弱法則（t分布）
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
X = []
Y = []
Z = []
c = 0
y = 0
z = 0
n = 1000
for k in range(3):
    for i in range(n):
        for j in range(2):
            x = np.random.randn()
            c += x*x
            z = np.random.randn()
        y += z/np.sqrt(c/2)
        X.append(i+1)
        Y.append(y/(i+1))
        Z.append(0)
    plt.plot(X, Y, linewidth = 1)
    plt.plot(X, Z, linewidth = 0.3)
    #plt.show()
    plt.savefig('t_' + str(k + 1) + '.png')
    plt.clf()
    X.clear()
    Y.clear()
    Z.clear()
    y = 0
