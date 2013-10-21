
function Cs=MIMO222_2T(Hr,He,P)

%Hr=rand(3,2)+j*rand(3,2);
%He=rand(3,2)+j*rand(3,2);

%{
Hr=[ 0.7442 + 1.4223i   1.1740 - 1.8109i
  -0.5172 + 0.4116i  -1.3020 + 0.2417i
   1.9755 + 0.4169i  -0.7105 + 0.7272i];
He=[  -0.4503 + 0.9711i  -0.7453 + 1.1555i
  -0.7089 + 0.1272i  -0.0506 + 0.5835i
  -0.1313 - 0.3833i   0.1974 + 0.1632i];
%}


Sr=P*Hr'*Hr;
Se=P*He'*He;
a1=Sr(1,1);
b1=Sr(1,2);
b1_star=Sr(2,1);
c1=Sr(2,2);
a2=Se(1,1);
b2=Se(1,2);
b2_star=Se(2,1);
c2=Se(2,2);
p1=-b1_star*b2-b1*b2_star-(1+a1)*(a2*c2-abs(b2)^2)-(1+a2)*(a1*c1-abs(b1)^2);
p2=2*b1_star*b2+2*b1*b2_star+(1+a1)*(a2-c2+a2*c2-abs(b2)^2)+(1+a2)*(a1-c1+a1*c1-abs(b1)^2);
p3=(1+a1)*(1+c2)+(1+a2)*(1+c1)-b1_star*b2-b1*b2_star;
q1=-a2*(c2+a2*c2-abs(b2)^2);
q2=a2-c2+a2^2+abs(b2)^2+a2*(a2*c2-abs(b2)^2);
q3=1+a2+c2+a2*c2-abs(b2)^2;
q4=-a1*(c1+a1*c1-abs(b1)^2);
q5=a1-c1+a1^2+abs(b1)^2+a1*(a1*c1-abs(b1)^2);
q6=1+a1+c1+a1*c1-abs(b1)^2;


t1=roots([-q3,p3,-q6]);
t2=roots([q2^2-4*q1*q3,-2*p2*q2+4*q1*p3+4*p1*q3,p2^2+2*q2*q5-4*q1*q6-4*q3*q4-4*p1*p3,-2*p2*q5+4*p1*q6+4*p3*q4,q5^2-4*q4*q6]);
m1=-1000;
m2=-1000;
for s=1:2
    tmp=t1(s,1);
   if  imag(tmp) <= 1e-10
       if real(tmp) > m1
           m1=real(tmp);
       end
   end
end

for s=1:4
    tmp=t2(s,1);
   if  abs(imag(tmp))<= 1e-6
       tmp2=(-tmp^2*q2+tmp*p2-q5)/(2*(-tmp^2*q1+tmp*p1-q4));
       if (real(tmp) > m2) && abs(tmp2)>0 && abs(tmp2)<1
           m2=real(tmp);
       end
   end
end

Cs=log2(max(m1,m2));
Cs=max(0,Cs);
end