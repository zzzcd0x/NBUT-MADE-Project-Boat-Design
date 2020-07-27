% writer:zzzcd0x
clear
clc
%----------------------------------粗筛-------------------------------------
K = -1;
M = 0.9295;
M_w = 0.8217;
L_w = 0.088;
H_mast = 0.5;
M_mast = 0.1078;

%储存答案用的数组
%船体方程为Ax^2 + By^2 = z
Ans_A = zeros(1,500,'double');      %船体方程中的A
Ans_B = zeros(1,500,'double');      %船体方程中的B
Ans_H = zeros(1,500,'double');      %船高
Ans_C = zeros(1,500,'double');      %135°吃水线方程截距
Ans_AB = zeros(1,500,'double');     %长宽比
Ans_toi = zeros(1,500,'double');    %复原力矩
Ans_COMZ = zeros(1,500,'double');   %重心z轴坐标
Ans_COB_x = zeros(1,500,'double');  %浮心x轴坐标
Ans_COB_z = zeros(1,500,'double');  %浮心z轴坐标
Ans_waterline = zeros(1,500,'double');%正浮吃水线高度

cnt = 0;%记录当前得到的合法答案数量

%枚举每个长度为0.6的区间中点是否符合条件
%里面的disp作用是让我知道运行到哪里了
for A = 13:0.3:30
    for B = 2:0.3:10
        disp(['working on :A ',num2str(A),' B ',num2str(B)]);
        for H = 0.12:0.01:0.14
            disp(['working on :h ',num2str(H)]);
            disp(['cnt ',num2str(cnt)]);
%筛长宽比
             if sqrt(A/B) < 2
                 continue;
             end
             if sqrt(A/B) > 3
                 continue;
             end
%求整船重心
            COM_z = getCOM(M_mast,H_mast,L_w,M_w,B);
            COM = [0 0 COM_z];
%正浮吃水线
            h = waterline(H,A,B);
%筛掉重心比吃水线高的
            if h <= COM_z
                continue;
            end
%135°吃水线
            C = waterline135(K,H,A,B);
            if C == 0
                continue;
            end
%求浮心和复原力矩
            COB = getCOB(K,H,A,B,C);
            toi = getTOI(M,COB,COM);
%储存135°时复原力矩小于0.01的答案
            if abs(toi) < 0.01
                    cnt = cnt+1;
                    Ans_A(cnt) = A;
                    Ans_B(cnt) = B;
                    Ans_H(cnt) = H;
                    Ans_C(cnt) = C;
                    Ans_toi(cnt) = toi;
                    Ans_COB_x(cnt) = COB(1);
                    Ans_COB_z(cnt) = COB(3);
                    Ans_COMZ(cnt) = COM(3);
                    Ans_waterline(cnt) = h;
                    Ans_AB(cnt) = sqrt(A/B);
            end
        end
    end
end
%答案输出到excel
Varname= {'A','B','H','COM','COBx','COBz','waterline135','waterline','Moment','AB'};
T = table(Ans_A',Ans_B',Ans_H',Ans_COMZ',Ans_COB_x',Ans_COB_z',Ans_C',Ans_waterline',Ans_toi',Ans_AB','VariableNames',Varname);
writetable(T,'Final_low_accF.xlsx');
type 'Final_low_accF.xlsx';