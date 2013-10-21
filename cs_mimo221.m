
function Cs=cs_mimo221(H,g,P)
%% system model is y=Hx+z; z=g'x+z
%H 2*2
%g 2*1
g=g';
A=eye(2)+P*H.'*H;
B=eye(2)+P*g.'*g;

C=B^(-1/2)*A*B^(-1/2);
[U V]=eig(C);
lamda_max=max(diag(V));
%Cs=1/2*log2(lamda_max);
Cs=max(0,log2(lamda_max));
Cs=real(Cs);

end
