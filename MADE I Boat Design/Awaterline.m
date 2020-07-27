clear
clc

B = 3.2;
K = -1;
H = 0.12;
M = 1.0893;
M_w = 0.7089;
L_w = 0.074;
H_mast = 0.5;
M_mast = 0.109;

COM_z = 0.0707;
COM = [0 0 COM_z];

As = [];
toi = [];

for A = 13:0.1:30
    h = waterline(H,M,A,B);
    C = waterline135(K,H,A,B);
    if C == 0
        continue;
    end
    COB = getCOB(K,H,A,B,C);
    As(end+1) = 2*sqrt(H/A);
    toi(end+1) = getTOI(M,COB,COM);
end

title('船宽与复原力矩的关系');
xlabel('船宽/(m)');
ylabel('复原力矩/(NM)');
grid on;
hold on;
plot(As,toi);
hold on;