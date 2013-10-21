

function cs=cs_miso_multipleEve(N_s,N_e,P,hs,he)
%{
N_s=4;%conductor number
N_e=2;%eavesdropper number, each with one antenna
P=10^(1/10);
%Tao=[2,3,4];
he=zeros(N_s,1,N_e);
for k = 1: N_e
    he(:,:,k)=0.3*(randn(N_s,1)+randn(N_s,1)*j);
end
hs=0.3*(randn(N_s,1)+randn(N_s,1)*j);
%}
%% important: hs'  he', do the transpose before calling the function

%initialization
t_min=0;
t_max=CN2CS_g(N_s,N_e,P,1e5*ones(N_e,1),hs,he);
ee=0.1;

%algorithm1
while (t_max-t_min>=ee)
t=(t_min+t_max)/2;

cvx_begin
    variable Tao(N_e) nonnegative;
    maximize 0
    subject to
        for k = 1: N_e
            CN2CS_g(N_s,N_e,P,Tao,hs,he) >=  t*(1+Tao(k));
        end
cvx_end

switch cvx_status
    case 'Infeasible'
        t_max=t;
    case 'Solved'
        t_min=t;
    otherwise
        t_max=t;
        %error('CN2CS_alg1 cvx status inconsist');
end
end
cs=log2(t_min);
cs=max(0,cs)
end
