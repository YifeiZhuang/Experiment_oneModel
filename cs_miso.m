function Cs=cs_miso(hs,he,P)
%% model is y=h'x+z; ye=Gx+z
%%hs Nt*1
%%he Ne*Nt
hs=hs';
N=size(hs,1);
A=eye(N)+P*hs*hs';
B=eye(N)+P*he'*he;

[V D]=eig(A/B);
lamda_max=max(diag(D));
Cs=max(0,log2(real(lamda_max)));
%Cs=real(Cs);
end