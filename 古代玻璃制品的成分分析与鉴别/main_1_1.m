warning off             % 关闭报警信息
close all               % 关闭开启的图窗
clear                   % 清空变量
clc                     % 清空命令行


%   对这些玻璃文物的表面风化与其玻璃类型、纹饰和颜色的关系进行分析
%   首先需要对数据集进行预处理（编码处理）
%   采用斯皮尔曼相关系数分析（Spearman相关系数）分析其相关性
%   同时采用	两样本 Kolmogorov-Smirnov 检验，以检验两组样本数据是否具有相同的分布。



res = xlsread('斯皮尔曼.xlsx');

%%  斯皮尔曼相关系数分析相关性
for i = 1: 3
    corr_index(i) = corr(res(:, i), res(:, end));
end

%%  显示柱状图结果
figure
bar(corr_index)
xlabel('特征序号')
ylabel('相关系数')
title('相关性分析结果图')

%%  Kolmogorov-Smirnov 检验
% 检验原假设，具有相同分布的总体的原假设。
for i = 1: 3
    tt_index(i) = kstest2(res(:, i), res(:, end));
end
% 返回值 h = 0 表明 kstest2 在默认的 5% 显著性水平上未拒绝原假设。

%%  输出检验结果
disp(' 双样本t检验分析结果:')
disp(tt_index)

