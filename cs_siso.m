function Secrecy_Capacity=cs_siso(h,g,P)

temp=log2(1+abs(h)^2*P)-log2(1+abs(g)^2*P);
Secrecy_Capacity=max(temp,0);
end