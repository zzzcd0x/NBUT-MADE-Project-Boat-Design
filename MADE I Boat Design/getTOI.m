function Ans = getTOI(M,COB,COM)

P = 45/180*pi;

g = 9.8;
F = [-g*M*sin(P) 0 -g*M*cos(P)];
temp = cross(COB - COM,F);
Ans = temp(2);

end

