function Ans = getCOB(K,H,A,B,C)

syms x y z

fun = @(x,y,z) 1 + 0.*x;
fun_x = @(x,y,z) x;
fun_z = @(x,y,z) z;
fun_solve = A.*x.^2-K.*x-C == 0;
temp = [];
temp = double(solve(fun_solve));
sort(temp);%排序后第一个为负数解，第二个为正数解
%---------------------------------区域1------------------------------------
Xmax = temp(2);
Xmin = (H-C)./K;
Ymax = @(x,y,z) sqrt((-A.*x.^2+K.*x+C)./B);
Ymin = @(x,y,z) -sqrt((-A.*x.^2+K.*x+C)./B);
Zmax = @(x,y,z) H + x.*0;
Zmin = @(x,y,z) K.*x+C;
Mx1 = integral3(fun_x,Xmin,Xmax,Ymin,Ymax,Zmin,Zmax);
Mz1 = integral3(fun_z,Xmin,Xmax,Ymin,Ymax,Zmin,Zmax);
M1 = integral3(fun,Xmin,Xmax,Ymin,Ymax,Zmin,Zmax);
%---------------------------------区域2------------------------------------
Xmax = temp(2);
Xmin = (H-C)./K;
Ymax = @(x,y,z) sqrt((H-A.*x.^2)./B);
Ymin = @(x,y,z) sqrt((K.*x+C-A.*x.^2)./B);
Zmax = @(x,y,z) H + 0.*x;
Zmin = @(x,y,z) A.*x.^2 + B.*y.^2;
Mx2 = 2*integral3(fun_x,Xmin,Xmax,Ymin,Ymax,Zmin,Zmax);
Mz2 = 2*integral3(fun_z,Xmin,Xmax,Ymin,Ymax,Zmin,Zmax);
M2 = 2*integral3(fun,Xmin,Xmax,Ymin,Ymax,Zmin,Zmax);
%---------------------------------区域3------------------------------------
Xmax = sqrt(H/A);
Xmin = temp(2);
Ymax = @(x,y,z) sqrt((H-A.*x.^2)./B);
Ymin = @(x,y,z) -sqrt((H-A.*x.^2)./B);
Zmin = @(x,y,z) A.*x.^2 + B.*y.^2;
Zmax = @(x,y,z) H + x.*0;
Mx3 = integral3(fun_x,Xmin,Xmax,Ymin,Ymax,Zmin,Zmax);
Mz3 = integral3(fun_z,Xmin,Xmax,Ymin,Ymax,Zmin,Zmax);
M3 = integral3(fun,Xmin,Xmax,Ymin,Ymax,Zmin,Zmax);
%--------------------------------------------------------------------------

X = (Mx1 + Mx2 + Mx3)./(M1 + M2 + M3);
Y = 0;
Z = (Mz1 + Mz2 + Mz3)./(M1 + M2 + M3);
Ans = [X Y Z];
end