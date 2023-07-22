%% 读取数据
clc;clear all,close all
gaojia=xlsread('C:\Users\0\Desktop\新建文件夹\数学建模\Excel\第四问\高钾.xlsx','Sheet1');
qianbei=xlsread('C:\Users\0\Desktop\新建文件夹\数学建模\Excel\第四问\铅钡.xlsx','Sheet1');
%差
C1=gaojia-qianbei;
%绝对值
C2=abs(C1);
%平方
C3=C2^2;
%根号
C4=C3^0.5;
%协方差
C5=cov(gaojia,qianbei);
%相关系数
r = corr2(gaojia,qianbei);