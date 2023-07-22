clear
clc
X=xlsread('高钾 -权重版.xlsx','Sheet1');
sample = normalization(X);
Visualize_SSE(X,8);

%查看二维聚类效果
data=X;
[idx, C, ~] = Kmeans(X, 2, 0, Inf);
figure('name', '二维聚类效果')
gscatter(data(:, 1), data(:, 2), idx, 'rgb')
hold on
plot(C(:, 1), C(:, 2), 'kx')
legend('Cluster 1',...
       'Cluster 2',...
       'Cluster 3',...
       'ClusterCentroid')


%查看三维聚类效果

[idx, C, ~] = Kmeans(X, 2, 0, Inf);
figure('name', '三维聚类效果')
plot3(C(:, 1), C(:, 2), C(:, 3), 'kx')
hold on
view(3)
plot3(X(idx==1,1),X(idx==1,2),X(idx==1,3),'r*')
hold on
plot3(X(idx==2,1),X(idx==2,2),X(idx==2,3),'b.')
hold on
plot3(X(idx==3,1),X(idx==3,2),X(idx==3,3),'gx')



%%  混淆矩阵
figure
cm = confusionchart(T_test, T_sim);
cm.Title = 'Confusion Matrix for Data';
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';
