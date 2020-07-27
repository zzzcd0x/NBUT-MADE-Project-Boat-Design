function Ans = waterline(H,M,A,B)

L = H/2;
R = H;
h_temp = -1;
%M = 0.9295;
Ans = 0;

while L <= R
    h = (L+R)/2;
%     if h_temp == h%·ÀÖ¹¿¨Ñ­»·
%         break;
%     end
%     h_temp = h;
    zmin = @(x,y) A.*x.^2 + B.*y.^2;
    zmax = @(x,y) h + x.*0;
    ymin = @(x) 0 + x.*0;
    ymax = @(x) ((h-A.*x.^2)/B).^0.5;
    xmin = 0;
    xmax = (h/A)^0.5;
    fun = @(x,y,z) 1 + x.*0;
    V = 4*integral3(fun,xmin,xmax,ymin,ymax,zmin,zmax);
    if abs(V*1000-M) < 0.1
        Ans = h;
    end
    if V*1000 < M
        L = h+0.00001;
    end
    if V*1000 > M
        R = h-0.00001;
    end
end

end