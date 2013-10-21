%clear;
N=2;

hs=(randn(N,1)+j*randn(N,1));

he=randn(N,1)+j*randn(N,1);
%C1=1:30;
%C2=1:30;

for i= 15
P=10^((i-5)/10);

cvx_begin SDP
   variable S_hat(N,N) complex symmetric semidefinite;
   %variable S_hat(N,N) complex symmetric;
   variable t;
   maximize (t+real(hs'*S_hat*hs));
   subject to
       t >= 0;
       real(trace(S_hat)) <= P*t;
       t+he'*S_hat*he == 1;
cvx_end

cvx_optval;
S_hat
C1=log2(cvx_optval)


%%%%%general paper
A=eye(N)+P*hs*hs';
B=eye(N)+P*he*he';

[V D]=eig(A/B);
lamda_max=max(diag(D));
C2=log2(lamda_max)
end
