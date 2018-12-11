import numpy as np
from sklearn.decomposition import PCA
from matplotlib import pyplot as plt

#CLASSを変えるときはzahyoとcolorも変えること
#データは「zahyo+誤差」
SIZE = 50 #各クラスのデータ数
CLASS = 4 #クラス数
ALL_SIZE = CLASS * SIZE
zahyo = np.array([[0,0,0,0],[4,4,0,0],[0,0,4,4],[4,0,4,0]])
color = ['red', 'blue', 'green','orange']


def data_set(A):
    for i in range(CLASS):
        for j in range(SIZE):
            A[i*SIZE+j] = [np.random.normal()+zahyo[i][0], np.random.normal()+zahyo[i][1],
                        np.random.normal()+zahyo[i][2], np.random.normal()+zahyo[i][3]]
    print(A)


def data_pca(A,X):
    pca = PCA()
    pca.fit(A)
    transformed = pca.fit_transform(A)
    pc1 = transformed[:, 0]
    pc2 = transformed[:, 1]
    
    plt.scatter(pc1,pc2,s=15)
    plt.title('principal component')
    plt.xlabel('pc1')
    plt.ylabel('pc2')
    plt.savefig('PCA.eps')
    plt.clf()
    for i in range(ALL_SIZE):
        X[i] = np.array([pc1[i], pc2[i]])
    

def update_C(C,U,X):
    N = np.zeros((CLASS,1))
    for i in range(ALL_SIZE):
        for j in range(CLASS):
            N[j] = np.linalg.norm(U[j] - X[i])
        C[i] = np.argmin(N)


def update_u(C,U,X):
    s = np.zeros((CLASS,2))
    c = np.zeros((CLASS,1))
    newU = np.zeros((CLASS,2))
    epsilon = 0
    for i in range(ALL_SIZE):
        for j in range(CLASS):
            if C[i] == j:
                s[j] = s[j] + X[i]
                c[j] = c[j] + 1

    for i in range(CLASS):
        epsilon = epsilon + np.linalg.norm(U[i] - s[i]/c[i])
        newU[i] = s[i]/c[i]
    
    return newU, epsilon


def print_clstering(C,U,X):
    clusterX = [[0] for i in range(CLASS)]
    clusterY = [[0] for i in range(CLASS)]
    for i in range(CLASS):
        del clusterX[i][0]
        del clusterY[i][0]

    for i in range(ALL_SIZE):
        for j in range(CLASS):
            if C[i] == j:
                clusterX[j].append(X[i][0])
                clusterY[j].append(X[i][1])

    print(C)

    for i in range(CLASS):
        plt.scatter(clusterX[i],clusterY[i], c=color[i], s=15)
        plt.scatter(U[i][0], U[i][1], c=color[i], s=50, marker='*')

    plt.title('clustering')
    plt.xlabel('pc1')
    plt.ylabel('pc2')
    plt.savefig('Clustering.eps')
    plt.show()


def main():
    #Aは生のデータ、XはPCAにより２次元に縮約されたデータ
    #Uはクラスターの中心座標、Cは各データのクラスインデックス
    A = np.zeros((ALL_SIZE,4))
    X = np.zeros((ALL_SIZE,2))
    C = np.zeros((ALL_SIZE,1))
    U = 6 * np.random.rand(CLASS,2) - 3 * np.ones((CLASS,2))
    
    #Aにデータを生成させ、主成分分析する
    data_set(A)
    data_pca(A,X)

    #Uの変化が小さくなるまでUとCの更新を繰り返す
    epsilon = 1
    while epsilon > 0.1:
        update_C(C,U,X)
        U, epsilon = update_u(C,U,X)
        
    #結果の出力
    print_clstering(C,U,X)


if __name__ == '__main__':
    main()
