%% I. 清空环境变量
clear all
clc
warning off

%% II. 导入数据
shujuc = xlsread('高钾铅钡分类.xlsx');
data = shujuc();
%%
% 1. 随机产生训练集/测试集
a = randperm(57);
Test = data(a(1:17),:);
Train = data(a(18:end),:);
M = size(Test, 1);
%%
% 2. 训练数据
P_train = Train(:, 1: end - 1);
T_train = Train(:, end);

%%
% 3. 测试数据
P_test = Test(:, 1: end - 1);
T_test = Test(:, end);

%% III. 创建决策树分类器
ctree = ClassificationTree.fit(P_train,T_train);

%%
% 1. 查看决策树视图
view(ctree);
view(ctree,'mode','graph');

%% IV. 仿真测试
T_sim = predict(ctree,P_test);

%% V. 结果分析
count_B = length(find(T_train == 1));
count_M = length(find(T_train == 2));
rate_B = count_B / 40;
rate_M = count_M / 40;
total_B = length(find(data(:,2) == 1));
total_M = length(find(data(:,2) == 2));
number_B = length(find(T_test == 1));
number_M = length(find(T_test == 2));
number_B_sim = length(find(T_sim == 1 & T_test == 1));
number_M_sim = length(find(T_sim == 2 & T_test == 2));
disp(['样本总数：' num2str(57)...
      '  高钾：' num2str(total_B)...
      '  铅钡：' num2str(total_M)]);
disp(['训练集总数：' num2str(40)...
      '  高钾：' num2str(count_B)...
      '  铅钡：' num2str(count_M)]);
disp(['测试集总数：' num2str(17)...
      '  高钾：' num2str(number_B)...
      '  铅钡：' num2str(number_M)]);
disp(['高钾测试集：' num2str(number_B_sim)...
      '  错误集：' num2str(number_B - number_B_sim)...
      '  准确率p1=' num2str(number_B_sim/number_B*100) '%']);
disp(['铅钡测试集：' num2str(number_M_sim)...
      '  错误集：' num2str(number_M - number_M_sim)...
      '  准确率p2=' num2str(number_M_sim/number_M*100) '%']);
  
%% VI. 叶子节点含有的最小样本数对决策树性能的影响
leafs = logspace(1,2,10);

N = numel(leafs);

err = zeros(N,1);
for n = 1:N
    t = ClassificationTree.fit(P_train,T_train,'crossval','on','minleaf',leafs(n));
    err(n) = kfoldLoss(t);
end
plot(leafs,err);
xlabel('叶子节点含有的最小样本数');
ylabel('交叉验证误差');
title('叶子节点含有的最小样本数对决策树性能的影响')

%% VII. 设置minleaf为13，产生优化决策树
OptimalTree = ClassificationTree.fit(P_train,T_train,'minleaf',13);
view(OptimalTree,'mode','graph')

%%
% 1. 计算优化后决策树的重采样误差和交叉验证误差
resubOpt = resubLoss(OptimalTree)
lossOpt = kfoldLoss(crossval(OptimalTree))

%%
% 2. 计算优化前决策树的重采样误差和交叉验证误差
resubDefault = resubLoss(ctree)
lossDefault = kfoldLoss(crossval(ctree))

%% VIII. 剪枝
[~,~,~,bestlevel] = cvLoss(ctree,'subtrees','all','treesize','min')
cptree = prune(ctree,'Level',bestlevel);
view(cptree,'mode','graph')

%%
% 1. 计算剪枝后决策树的重采样误差和交叉验证误差
resubPrune = resubLoss(cptree)
lossPrune = kfoldLoss(crossval(cptree))



%%  绘图
figure
plot(1: M, T_test, 'r-*', 1: M, T_sim, 'b-o', 'LineWidth', 1)
legend('真实值', '预测值')
xlabel('预测样本')
ylabel('预测结果')
%%  计算准确率
error1 = sum((T_sim == T_test)) / M * 100 ;
string = {'预测结果对比'; ['准确率=' num2str(error1) '%']};
title(string)
xlim([1, M])
grid


%%  混淆矩阵
figure
cm = confusionchart(T_test, T_sim);
cm.Title = 'Confusion Matrix for Data';
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';

