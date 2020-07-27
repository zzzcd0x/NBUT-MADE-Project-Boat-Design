function Ans = waterline135(K,H,A,B)

%--------------------------------debug-------------------------------------
%K = -1;
%H = 0.12;
%Ans_V = [];
%--------------------------------------------------------------------------

%�Ƚ��𰸳�ʼ��Ϊ0����ֹ���ն��ֽ�����Ǵ�
Ans = 0;
M = 0.9349;
R = 1000;
syms x y z
delta = 0.0001;     %��������
length = 0.000001;  %����

X_L = sqrt(H/A);
L = H + K.*X_L;
R = H - K.*X_L - 0.0001;
    while L <= R
        C = (L+R)./2;
        %--------------------------------����1----------------------------------
        fun = @(x,y,z) 1 + 0.*x;
        fun_solve = A.*x.^2-K.*x-C == 0;
        temp = [];
        temp = double(solve(fun_solve));
        sort(temp);
        Xmax = temp(2);
        Xmin = (H-C)./K;
        Ymax = @(x,y,z) sqrt((-A.*x.^2+K.*x+C)./B);
        Ymin = @(x,y,z) -sqrt((-A.*x.^2+K.*x+C)./B);
        Zmax = @(x,y,z) H + x.*0;
        Zmin = @(x,y,z) K.*x+C;
        V1 = integral3(fun,Xmin,Xmax,Ymin,Ymax,Zmin,Zmax);
        %--------------------------------����2----------------------------------
        Xmax = temp(2);
        Xmin = (H-C)./K;
        Ymax = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Ymin = @(x,y,z) sqrt((K.*x+C-A.*x.^2)./B);
        Zmax = @(x,y,z) H + 0.*x;
        Zmin = @(x,y,z) A.*x.^2 + B.*y.^2;
        V2 = 2*integral3(fun,Xmin,Xmax,Ymin,Ymax,Zmin,Zmax);
        %--------------------------------����3----------------------------------
        Xmax = sqrt(H/A);
        Xmin = temp(2);
        Ymax = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Ymin = @(x,y,z) -sqrt((H-A.*x.^2)./B);
        Zmin = @(x,y,z) A.*x.^2 + B.*y.^2;
        Zmax = @(x,y,z) H + x.*0;
        V3 = integral3(fun,Xmin,Xmax,Ymin,Ymax,Zmin,Zmax);
        %----------------------------------------------------------------------- 
        V = 1000.*(V1+V2+V3);
        if abs(V-M) <= delta
           Ans = C;%�ſ�ˮ�����봬��������ľ���ֵС��deltaʱ���´�
        end

        if V<M
            R = C-length;
        end
        if V>M
            L = C+length;
        end
    end

end