clear
clc

A = 21.1;
B = 3.2;
K = -1;
H = 0.12;
M = 1.0893;
M_w = 0.7089;
L_w = 0.074;
H_mast = 0.5;
M_mast = 0.109;

As = [];
toi = [];
COM = [0 0 0.0755];
for H = 0.1:0.01:0.2
    h = waterline(H,M,A,B);
    C = waterline135(K,H,A,B);
   
    if C == 0
        continue;
    end
    COB = getCOB(K,H,A,B,C);
    As(end+1) = H;
    toi(end+1) = getTOI(M,COB,COM);
end

title('船高与复原力矩的关系');
xlabel('船高/(m)');
ylabel('复原力矩/(Nm)');
grid on;
hold on;
plot(As,toi);
hold on;