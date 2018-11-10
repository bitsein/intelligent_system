#カイ二乗分布（DOFは0から10）
import numpy as np
import matplotlib.pyplot as plt

Y = []
y = 0
for j in range(10):
    for k in range(1000000):
        for l in range(j+1):
            # 平均 50, 標準偏差 10 の正規乱数を1,000件生成
            x = np.random.randn()
            y += x*x
        Y.append(y)
        y=0
    plt.hist(Y, bins = 300)
    plt.savefig('DOF_'+ str(j+1) +'.png')
    Y.clear()
    plt.clf()


