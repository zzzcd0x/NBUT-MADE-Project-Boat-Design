clear
clc

A = 21.1;
B = 3.2;
H = 0.12;
M_mast = 0.109;
L_w = 0.074;
H_mast = 0.5;

Ms = [];
Ans = [];

for M = 0.7:0.001:1
    Ms(end+1) = M;
    Ans(end+1) = getCOM(M_mast,H_mast,L_w,M,B);
end

title('�������������ĵĹ�ϵ');
xlabel('��������/(kg)');
ylabel('���ĸ߶�/(m)');
hold on;
plot(Ms,Ans);