clear
clc

A = 22.8;
B = 3.8;
H = 0.12;

M_mast = 0.109;
delta = 0.1598;
Ms = [];
Ans = [];

for M = 0.7:0.01:1
    h = waterline(H,M+M_mast+delta,A,B);
    if h == 0
        continue;
    end
    Ans(end+1) = h;
    Ms(end+1) = M;
end

title('������ˮ�������������Ĺ�ϵ');
xlabel('��������/(kg)');
ylabel('��ˮ�����(m)');
grid on;
hold on;
semilogy(Ms,Ans);
hold on;