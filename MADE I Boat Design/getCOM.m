function Ans = getCOM(M_mast,H_mast,L_w,M_w,B,M)

%M_mast 桅杆质量
%H_mast 桅杆高度
%M_w 重物质量
%L_w 重物长度

H_w = 0.02 + (B*L_w^2)/4 + 0.015;%重物重心

H_m = H_mast/2 + 0.02 + H_w;%桅杆重心

H = 0.06;

Ans = (M_mast*H_m + M_w*H_w + H * 0.1598)/M;%整体重心

end