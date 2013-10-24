%{
f=1e5:1e5:80e6;


dd=load('data_H_Position.mat');
H_mimo222=dd.HPosition;
He_mimo222=dd.HePosition;

H_siso=H_mimo222(1,1,:,:);
He_siso=He_mimo222(1,1,:,:);

H_miso_uu=H_mimo222(1,:,:,:);
He_miso_uu=He_mimo222(1,:,:,:);


H_miso_u=H_mimo222(1,:,:,:);
He_miso_u=He_mimo222(1:2,1:2,:,:);


H_miso_du=H_mimo222(1,1:2,:,:);
He_miso_du=He_mimo222(2,1:2,:,:);


H_mimo221=H_mimo222(1:2,1:2,:,:);
He_mimo221=He_mimo222(2,1:2,:,:);

testN=100;
Cs_cdfsiso=zeros(testN,1);
Cs_cdfmiso_uu=zeros(testN,1);
Cs_cdfmiso_u=zeros(testN,1);
Cs_cdfmiso_du=zeros(testN,1);
Cs_cdfmimo221=zeros(testN,1);
Cs_cdfmimo222=zeros(testN,1);
P=10^(15/10);%15dB

for i=1: testN   
    Cs_sum=0;
    for k3 = 1 : length(f)
      Cs_sum=Cs_sum+cs_siso(H_siso(:,:,k3,i),He_siso(:,:,k3,i),P);
    end
    Cs_cdfsiso(i)=Cs_sum/length(f);
end

for i=1: testN   
    Cs_sum=0;
    for k3 = 1 : length(f)
      Cs_sum=Cs_sum+cs_miso(H_miso_uu(:,:,k3,i),He_miso_uu(:,:,k3,i),P);
    end
    Cs_cdfmiso_uu(i)=Cs_sum/length(f);
end

for i=1: testN   
    Cs_sum=0;
    for k3 = 1 : length(f)
      Cs_sum=Cs_sum+cs_miso(H_miso_u(:,:,k3,i),He_miso_u(:,:,k3,i),P);
    end
    Cs_cdfmiso_u(i)=Cs_sum/length(f);
end

for i=1: testN   
    Cs_sum=0;
    for k3 = 1 : length(f)
      Cs_sum=Cs_sum+cs_miso(H_miso_du(:,:,k3,i),He_miso_du(:,:,k3,i),P);
    end
    Cs_cdfmiso_du(i)=Cs_sum/length(f);
end

for i=1: testN   
    Cs_sum=0;
    for k3 = 1 : length(f)
      Cs_sum=Cs_sum+cs_mimo221(H_mimo221(:,:,k3,i),He_mimo221(:,:,k3,i),P);
    end
    Cs_cdfmimo221(i)=Cs_sum/length(f);
end

for i=1: testN   
    Cs_sum=0;
    for k3 = 1 : length(f)
      Cs_sum=Cs_sum+MIMO222_2T(H_mimo222(:,:,k3,i),He_mimo222(:,:,k3,i),P);
    end
    Cs_cdfmimo222(i)=Cs_sum/length(f);
end

%}
figure(1);
[f2,x]=ecdf(Cs_cdfsiso);
plot(x,f2,'k-','LineWidth',2);
hold on;

[f2,x]=ecdf(Cs_cdfmiso_du);
plot(x,f2,'m-','LineWidth',2);
hold on;

[f2,x]=ecdf(Cs_cdfmiso_uu);
plot(x,f2,'g--','LineWidth',2);
hold on;

[f2,x]=ecdf(Cs_cdfmiso_u);
plot(x,f2,'c-.','LineWidth',2);
hold on;

[f1,x]=ecdf(Cs_cdfmimo221);
plot(x,f1,'b-','LineWidth',2);
hold on;


[f1,x]=ecdf(Cs_cdfmimo222);
plot(x,f1,'r-','LineWidth',2);
hold on;

grid on;
xlabel('secrecy capacity bit/Hz');
ylabel('Empirical CDF');
legend('SISO','MISO E(N-PE) B(N-P)','MISO E(N-P) B(N-P)','MISO B(N-P)','MIMO221 E(N-PE)','MIMO222');





figure(2);
whereTap=1:100;


plot(whereTap,Cs_cdfsiso,'k-','LineWidth',2);
hold on;

plot(whereTap,Cs_cdfmiso_du,'m-','LineWidth',2);
hold on;

plot(whereTap,Cs_cdfmiso_uu,'g--','LineWidth',2);
hold on;

plot(whereTap,Cs_cdfmiso_u,'c-.','LineWidth',2);
hold on;

plot(whereTap,Cs_cdfmimo221,'b-','LineWidth',2);
hold on;



plot(whereTap,Cs_cdfmimo222,'r-','LineWidth',2);
hold on;



grid on;
label('Eavesdropper wiretapping position at line1+line2');
ylabel('Secrecy capacity (bit/Hz)');
legend('SISO','MISO E(N-PE) B(N-P)','MISO E(N-P) B(N-P)','MISO B(N-P)','MIMO221 E(N-PE)','MIMO222');