% writer:zzzcd0x
clear
clc
%---------------------------��ɸ-------------------------------------------
K = -1;
M = 0.9295;

%��Щ�����ǴӴ�ɸ������ֶ�ѡ��
tot = 6;
As = [21.1 21.1 20.8 20.8 20.5 14.8];
Bs = [3.2 2.6 3.2 4.4 3.2 2];
Hs = [0.12 0.12 0.12 0.12 0.12 0.14];
%-----------------------------------
%����𰸵����� ->����ʹ�ɸһ��
Ans_A = zeros(1,500,'double');
Ans_B = zeros(1,500,'double');
Ans_H = zeros(1,500,'double');
Ans_h = zeros(1,500,'double');
Ans_C = zeros(1,500,'double');
Ans_AB = zeros(1,500,'double');
Ans_toi = zeros(1,500,'double');
Ans_COMZ = zeros(1,500,'double');
Ans_COB_x = zeros(1,500,'double');
Ans_COB_y = zeros(1,500,'double');
Ans_COB_z = zeros(1,500,'double');
Ans_waterline = zeros(1,500,'double');

cnt = 0;
%�������ɸ���� ֻ��ɸѡ�����в��
for i = 1:1:tot
    for A = As(i) - 0.3 : 0.1 : As(i) + 0.3
        for B = Bs(i) - 0.3 : 0.1 : Bs(i) + 0.3
            H = Hs(i);
            disp(['working on :A ',num2str(A),' B ',num2str(B)]);
            disp(['cnt ',num2str(cnt)]);
            %ɸ������������
            if 2*sqrt(H/A) > 0.25
                continue;
            end
            if 2*sqrt(H/B) > 0.4
                continue;
            end
            %ɸ�����
            if sqrt(A/B) < 2.0
                continue;
            end
            if sqrt(A/B) > 3.0
                continue;
            end
            COM_z = getCOM(0.1078,0.5,0.088,0.8217,B);
            
            COM = [0 0 COM_z];
            h = waterline(H,A,B);
            if h <= COM_z
                continue;
            end
            C = waterline140(K,H,A,B);
            if C == 0
                continue;
            end
            COB = getCOB(K,H,A,B,C);
            toi = getTOI(M,COB,COM);
            %����135��ʱ��ԭ����С��0.001�Ĵ�
            if abs(toi) < 0.001
                    cnt = cnt+1;
                    Ans_AB(cnt) = sqrt(A/B);
                    Ans_A(cnt) = A;
                    Ans_B(cnt) = B;
                    Ans_H(cnt) = H;
                    Ans_C(cnt) = C;
                    Ans_toi(cnt) = toi;
                    Ans_waterline(cnt) = h;
                    Ans_COB_x(cnt) = COB(1);
                    Ans_COB_z(cnt) = COB(3);
                    Ans_COMZ(cnt) = COM(3);
            end
        end
    end
end
%����ܳ�����������excel
if cnt ~= 0
    Varname= {'A','B','H','COM','COBx','COBz','waterline135','waterline','Moment','AB'};
    T = table(Ans_A',Ans_B',Ans_H',Ans_COMZ',Ans_COB_x',Ans_COB_z',Ans_C',Ans_waterline',Ans_toi',Ans_AB','VariableNames',Varname);
    writetable(T,'Final_high_accF.xlsx');
    type 'Final_high_accF.xlsx'
    else
        disp('non');
end