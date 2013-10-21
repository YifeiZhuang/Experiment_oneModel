function [Yr,H]=getLoad(f,Y,Z,y,x)
Yr=zeros(size(Y));

N=size(Y,1);
yy=zeros(N,N,length(f));
H=zeros(N,N,length(f));
if (size(y,3)==1)
    for i=1:length(f)
        yy(:,:,i)=eye(N)*y;
    end
else
    yy=y;
end

for i= 1:length(f)
      
[T,A]=eig(Y(:,:,i)*Z(:,:,i));
Tao=sqrt(A);
e1=diag(exp(+diag(Tao)*x));
e2=diag(exp(-diag(Tao)*x));
Zc=Y(:,:,i)^(-1)*T*Tao*T^(-1);
Yc=Zc^(-1);
rho=T^(-1)*Yc*(yy(:,:,i)+Yc)^(-1)*(yy(:,:,i)-Yc)*Zc*T;

Yr(:,:,i)=T*(e1+e2*rho)*(e1-e2*rho)^(-1)*T^(-1)*Yc;
H(:,:,i)=Zc*T*(eye(N)-rho)*(e1-e2*rho)^(-1)*T^(-1)*Zc^(-1);
    
end
end