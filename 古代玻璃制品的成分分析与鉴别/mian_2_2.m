%%  清空环境变量
clear
clc
warning off

%%  导入数据
res = xlsread('铅钡亚分类.xlsx');

%%  参数设置
num_class = 3;              % 聚类类别数目
Tag = 0;                    % 数据集中是否包含标签
M  = size(res, 1);          % 样本数目

%%  划分特征与标签
if (Tag == 1)

    num_class = length(unique(res(:, end)));  % 聚类类别数目
    P_train = res(: , 1 : end - 1)';          % 输入特征
    T_train = res(: , end)';                  % 真实标签
else

    P_train = res';                           % 输入特征
end

%%  数据归一化
[p_train, ps_input] = mapminmax(P_train, 0, 1);

%%  建立网络
net = newsom(p_train, num_class);

%%  设置训练参数
net.trainParam.epochs = 2000;   % 最大迭代次数
net.trainParam.goal = 1e-5;     % 目标训练误差
net.trainParam.lr = 0.01;       % 学习率

%%  训练网络
net = train(net, p_train);

%%  仿真预测
t_sim1 = sim(net, p_train);

%%  反归一化
T_sim1 = vec2ind(t_sim1);

%%  主成分分析 -- 降维
p_train = p_train';
[~, pc_train] =  pca(p_train);

%%  空间预设置（有多少类别设置多少个）
idt1 = []; idt2 = []; 
idt3 = []; idt4 = []; 

%%  聚类类别
for i = 1: M

    % 聚类1
    if T_sim1(i) == 1
        idt1 = [idt1; pc_train(i, 1 : 2)];
    end
    
    % 聚类2
    if T_sim1(i) == 2
        idt2 = [idt2; pc_train(i, 1 : 2)];
    end
    
    % 聚类3
    if T_sim1(i) == 3
        idt3 = [idt3; pc_train(i, 1 : 2)];
    end


    % 如果存在其它类别，继续对应增加即可
    % -------------------------------
    % -------------------------------

end

%%  绘制聚类类别散点图
figure
plot(idt1(:, 1), idt1(:, 2), '*', 'LineWidth', 1)
hold on
plot(idt2(:, 1), idt2(:, 2), '*', 'LineWidth', 1)
hold on
plot(idt3(:, 1), idt3(:, 2), '*', 'LineWidth', 1)
hold on

% 如果存在其它类别，继续对应增加即可
% -------------------------------
% -------------------------------

%%  空间预设置（有多少类别设置多少个）
idx1 = []; idx2 = []; 
idx3 = []; idx4 = [];

%%  存在真实类别
if Tag == 1
    for i = 1: M

        % 类别1
        if T_train(i) == 1
            idx1 = [idx1; pc_train(i, 1 : 2)];
        end

        % 类别2
        if T_train(i) == 2
            idx2 = [idx2; pc_train(i, 1 : 2)];
        end
    
        % 类别3
        if T_train(i) == 3
            idx3 = [idx3; pc_train(i, 1 : 2)];
        end
    
        % 如果存在其它类别，继续对应增加即可
        % -------------------------------
        % -------------------------------
    
    end

%%  绘制真实类别散点图
    plot(idx1(:, 1), idx1(:, 2), 'o', 'LineWidth', 1)
    hold on
    plot(idx2(:, 1), idx2(:, 2), 'o', 'LineWidth', 1)
    hold on
    plot(idx3(:, 1), idx3(:, 2), 'o', 'LineWidth', 1)

    % 如果存在其它类别，继续对应增加即可
    % -------------------------------
    % -------------------------------
    
end

%%  图形的后续设置
% 这里需要自行根据实际情况进行修改 （有无真实类别，类别数目）
legend('聚类类别A', '聚类类别B', '聚类类别C')

xlabel('降维后第一维度')
ylabel('降维后第二维度')
string = {'聚类可视化'};
title(string)
grid on