function Ans = getCOM(M_mast,H_mast,L_w,M_w,B,M)

%M_mast Φ������
%H_mast Φ�˸߶�
%M_w ��������
%L_w ���ﳤ��

H_w = 0.02 + (B*L_w^2)/4 + 0.015;%��������

H_m = H_mast/2 + 0.02 + H_w;%Φ������

H = 0.06;

Ans = (M_mast*H_m + M_w*H_w + H * 0.1598)/M;%��������

end