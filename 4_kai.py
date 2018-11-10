#中心極限定理（カイ二乗分布）
import numpy as np
import matplotlib.pyplot as plt

Y = []
y = 0
n = 10000
for l in range(3):
    for k in range(10000):
        for i in range(n):
            for j in range(2):
                x = np.random.randn()
                y += x*x
        Y.append(((y/n)-2) / (4 / np.sqrt(n)))
        y = 0
    plt.hist(Y, bins = 100)
    plt.savefig('中心極限_' + str(l + 1) + '.png')
    plt.clf()
    Y.clear()
