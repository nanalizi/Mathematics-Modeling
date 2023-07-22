%%  清空环境变量
warning off             % 关闭报警信息
close all               % 关闭开启的图窗
clear                   % 清空变量
clc                     % 清空命令行

%%  读取处理后的数据集
res_gj = xlsread('高钾铅钡分类.xlsx');
M = size(res_gj, 1);

%%  添加截距项
P_train = res_gj(:, 1: end - 1);
T_train = res_gj(:, end);

%%  建立模型
ctree = fitctree(P_train, T_train, 'MinLeafSize', 8);

%%  查看决策树视图
view(ctree, 'mode', 'graph');

%%  仿真测试
T_sim1 = predict(ctree, P_train);

%%  计算准确率
error1 = sum((T_sim1 == T_train)) / M * 100 ;

%%  绘图
figure
plot(1: M, T_train, 'r-*', 1: M, T_sim1, 'b-o', 'LineWidth', 1)
legend('真实值', '预测值')
xlabel('预测样本')
ylabel('预测结果')
string = {'预测结果对比'; ['准确率=' num2str(error1) '%']};
title(string)
xlim([1, M])
grid

%%  混淆矩阵
figure
cm = confusionchart(T_train, T_sim1);
cm.Title = 'Confusion Matrix for Data';
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';
