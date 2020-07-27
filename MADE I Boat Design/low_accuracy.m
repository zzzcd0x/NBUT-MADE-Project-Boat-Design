% writer:zzzcd0x
clear
clc
%----------------------------------��ɸ-------------------------------------
K = -1;
M = 0.9295;
M_w = 0.8217;
L_w = 0.088;
H_mast = 0.5;
M_mast = 0.1078;

%������õ�����
%���巽��ΪAx^2 + By^2 = z
Ans_A = zeros(1,500,'double');      %���巽���е�A
Ans_B = zeros(1,500,'double');      %���巽���е�B
Ans_H = zeros(1,500,'double');      %����
Ans_C = zeros(1,500,'double');      %135���ˮ�߷��̽ؾ�
Ans_AB = zeros(1,500,'double');     %�����
Ans_toi = zeros(1,500,'double');    %��ԭ����
Ans_COMZ = zeros(1,500,'double');   %����z������
Ans_COB_x = zeros(1,500,'double');  %����x������
Ans_COB_z = zeros(1,500,'double');  %����z������
Ans_waterline = zeros(1,500,'double');%������ˮ�߸߶�

cnt = 0;%��¼��ǰ�õ��ĺϷ�������

%ö��ÿ������Ϊ0.6�������е��Ƿ��������
%�����disp����������֪�����е�������
for A = 13:0.3:30
    for B = 2:0.3:10
        disp(['working on :A ',num2str(A),' B ',num2str(B)]);
        for H = 0.12:0.01:0.14
            disp(['working on :h ',num2str(H)]);
            disp(['cnt ',num2str(cnt)]);
%ɸ�����
             if sqrt(A/B) < 2
                 continue;
             end
             if sqrt(A/B) > 3
                 continue;
             end
%����������
            COM_z = getCOM(M_mast,H_mast,L_w,M_w,B);
            COM = [0 0 COM_z];
%������ˮ��
            h = waterline(H,A,B);
%ɸ�����ıȳ�ˮ�߸ߵ�
            if h <= COM_z
                continue;
            end
%135���ˮ��
            C = waterline135(K,H,A,B);
            if C == 0
                continue;
            end
%���ĺ͸�ԭ����
            COB = getCOB(K,H,A,B,C);
            toi = getTOI(M,COB,COM);
%����135��ʱ��ԭ����С��0.01�Ĵ�
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
%�������excel
Varname= {'A','B','H','COM','COBx','COBz','waterline135','waterline','Moment','AB'};
T = table(Ans_A',Ans_B',Ans_H',Ans_COMZ',Ans_COB_x',Ans_COB_z',Ans_C',Ans_waterline',Ans_toi',Ans_AB','VariableNames',Varname);
writetable(T,'Final_low_accF.xlsx');
type 'Final_low_accF.xlsx';