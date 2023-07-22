clear all
clc
%数据格式
format long
%前20组数据
X0=xlsread('表单一·编码.xlsx','A2:C45');
%全部25组数据：验证和回归
XE=xlsread('表单一·编码.xlsx','A2:C59');
%前20组评估的数据值：P
Y0=xlsread('表单一·编码.xlsx','D2:D45');
n=size(Y0,1);
%π和P的映射关系
for i=1:n
    if Y0(i)==0
        Y1(i,1)=0.25;
    else
        Y1(i,1)=0.75;
    end
end
%构建常系数
X1=ones(size(X0,1),1);
X=[X1,X0];
Y=log(Y1./(1-Y1));
b=regress(Y,X);
%模型验证的应用
for i=1:size(XE,1)
pai0=exp(b(1)+b(2)*XE(i,1)+b(3)*XE(i,2)+b(4)*XE(i,3))/(1+exp(b(1)+b(2)*XE(i,1)+b(3)*XE(i,2)+b(4)*XE(i,3)));
    if(pai0<=0.5)
        P(i)=0;
    else
        P(i)=1;
    end
end
%回归结果
disp(['回归系数：' num2str(b') '  ']);
disp(['评估结果：' num2str(P)  '   ']);