import pandas as pd
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
df_features = pd.read_csv('铅钡 -权重版.csv', encoding='gbk')
'利用SSE选择k'
SSE = []  # 存放每次结果的误差平方和
for k in range(1, 9):
    estimator = KMeans(n_clusters=k)  # 构造聚类器
    estimator.fit(df_features[['二氧化硅(SiO2)',	'氧化钠(Na2O)', '氧化钙(CaO)',	'氧化铝(Al2O3)',	'氧化铜(CuO)',	'氧化铅(PbO)',	'氧化钡(BaO)',	'五氧化二磷(P2O5)',	'二氧化硫(SO2)']])
    SSE.append(estimator.inertia_)
X = range(1, 9)
plt.xlabel('k')
plt.ylabel('SSE')
plt.plot(X, SSE, 'o-')
plt.show()


#
# import pandas as pd
# from sklearn.cluster import KMeans
# import matplotlib.pyplot as plt
# df_features = pd.read_csv('高钾 -权重版.csv', encoding='gbk')
# '利用SSE选择k'
# SSE = []  # 存放每次结果的误差平方和
# for k in range(1, 9):
#     estimator = KMeans(n_clusters=k)  # 构造聚类器
#     estimator.fit(df_features[['二氧化硅(SiO2)',	'氧化钠(Na2O)',	'氧化钾(K2O)',	'氧化钙(CaO)',	'氧化铝(Al2O3)',	'氧化铁(Fe2O3)',	'氧化铜(CuO)',	'五氧化二磷(P2O5)']])
#     SSE.append(estimator.inertia_)
# X = range(1, 9)
# plt.xlabel('k')
# plt.ylabel('SSE')
# plt.plot(X, SSE, 'o-')
# plt.show()