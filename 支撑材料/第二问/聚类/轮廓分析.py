import pandas as pd
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score
import matplotlib.pyplot as plt
# featureList = ['二氧化硅(SiO2)',	'氧化钠(Na2O)', '氧化钙(CaO)',	'氧化铝(Al2O3)',	'氧化铜(CuO)',	'氧化铅(PbO)',	'氧化钡(BaO)',	'五氧化二磷(P2O5)',	'二氧化硫(SO2)']  #表头

df_features = pd.read_csv('铅钡 -权重版.csv', encoding='gbk')
Scores = []  # 存放轮廓系数
for k in range(2, 9):
    estimator = KMeans(n_clusters=k)  # 构造聚类器
    estimator.fit(df_features[['二氧化硅(SiO2)',	'氧化钠(Na2O)', '氧化钙(CaO)',	'氧化铝(Al2O3)',	'氧化铜(CuO)',	'氧化铅(PbO)',	'氧化钡(BaO)',	'五氧化二磷(P2O5)',	'二氧化硫(SO2)']])
    Scores.append(silhouette_score(df_features[['二氧化硅(SiO2)',	'氧化钠(Na2O)', '氧化钙(CaO)',	'氧化铝(Al2O3)',	'氧化铜(CuO)',	'氧化铅(PbO)',	'氧化钡(BaO)',	'五氧化二磷(P2O5)',	'二氧化硫(SO2)']], estimator.labels_, metric='euclidean'))
X = range(2, 9)
plt.xlabel('k')
plt.ylabel('Silhouette Coefficient')
plt.plot(X, Scores, 'o-')
plt.show()


#
#
# import pandas as pd
# from sklearn.cluster import KMeans
# from sklearn.metrics import silhouette_score
# import matplotlib.pyplot as plt
# # '二氧化硅(SiO2)',	'氧化钠(Na2O)',	'氧化钾(K2O)',	'氧化钙(CaO)',	'氧化铝(Al2O3)',	'氧化铁(Fe2O3)',	'氧化铜(CuO)',	'五氧化二磷(P2O5)'
#
# df_features = pd.read_csv('高钾 -权重版.csv', encoding='gbk')
# Scores = []  # 存放轮廓系数
# for k in range(2, 9):
#     estimator = KMeans(n_clusters=k)  # 构造聚类器
#     estimator.fit(df_features[['二氧化硅(SiO2)',	'氧化钠(Na2O)',	'氧化钾(K2O)',	'氧化钙(CaO)',	'氧化铝(Al2O3)',	'氧化铁(Fe2O3)',	'氧化铜(CuO)',	'五氧化二磷(P2O5)']])
#     Scores.append(silhouette_score(df_features[['二氧化硅(SiO2)',	'氧化钠(Na2O)',	'氧化钾(K2O)',	'氧化钙(CaO)',	'氧化铝(Al2O3)',	'氧化铁(Fe2O3)',	'氧化铜(CuO)',	'五氧化二磷(P2O5)']], estimator.labels_, metric='euclidean'))
# X = range(2, 9)
# plt.xlabel('k')
# plt.ylabel('Silhouette Coefficient')
# plt.plot(X, Scores, 'o-')
# plt.show()
