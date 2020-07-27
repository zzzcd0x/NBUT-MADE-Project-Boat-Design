clear
clc

A = 21.1;
K = -1;
H = 0.12;
M = 1.0893;
M_w = 0.7089;
L_w = 0.074;
H_mast = 0.5;
M_mast = 0.109;

Ls = [];
Bs = [];
Cs = [];
toi = [];
COBx = [];
COBz = [];
COMs = [];

for B = 1:0.3:4
    h = waterline(H,M,A,B);
    C = waterline135(K,H,A,B);
    COM_z = getCOM(M_mast,H_mast,L_w,M_w,B,M);
    COM = [0 0 COM_z];
    if C == 0
        continue;
    end
    COMs(end+1) = COM_z;
    Cs(end+1) = C;
    Bs(end+1) = B;
    COB = getCOB(K,H,A,B,C);
    COBx(end+1) = COB(1);
    COBz(end+1) = COB(3);
    Ls(end+1) = 2*sqrt(H/B);
    toi(end+1) = getTOI(M,COB,COM);
end

title('船长与复原力矩的关系');
xlabel('船长/(m)');
ylabel('复原力矩/(Nm)');
grid on;
hold on;
plot(Ls,toi);
hold on;