function [H,G]=TF_222(f,Y1,Z1,len1,Y2,Z2,len2,Y_L2,Yb,Zb,lenb,Y_Lb)

[Yr2,H2]=getLoad(f,Y2,Z2,Y_L2,len2);
[Yrb,Hb]=getLoad(f,Yb,Zb,Y_Lb,lenb);
Yrtmp=Yrb+Yr2;
[Yr1,H1]=getLoad(f,Y1,Z1,Yrtmp,len1);

for k=1:length(f)
    H(:,:,k)=H2(:,:,k)*H1(:,:,k);%the order: right to left
    G(:,:,k)=Hb(:,:,k)*H1(:,:,k);
end