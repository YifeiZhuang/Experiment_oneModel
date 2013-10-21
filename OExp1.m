%% all the transfer function's dimension are noted as N_rx * N_tx
% therefore, MIMO: 2*2; MISO: 1*2....
% data_H_Position 2x2xlength(f), for both Bob and Eve
% other transfer functions for are extracted from mimo222 as:
% miso: first row or second row

%% important: secrecy capacity functions are revised such that 
%  h's are directly put there to call the functions



%%
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



tapLocation=50;
SNR=1:40;
Cs_siso=zeros(length(SNR),1);
Cs_miso_uu=zeros(length(SNR),1);
Cs_miso_u=zeros(length(SNR),1);
Cs_miso_du=zeros(length(SNR),1);
Cs_mimo221=zeros(length(SNR),1);
Cs_mimo222=zeros(length(SNR),1);


for i=1 : length(SNR)
    P=10^(i/10);
    Cs_sum=0;
    for k3 = 1 : length(f)
      Cs_sum=Cs_sum+cs_siso(H_siso(:,:,k3,tapLocation),He_siso(:,:,k3,tapLocation),P);
    end
    Cs_siso(i)=Cs_sum/length(f);

  
    Cs_sum=0;
    for k3 = 1 : length(f)
      Cs_sum=Cs_sum+cs_miso(H_miso_uu(:,:,k3,tapLocation),He_miso_uu(:,:,k3,tapLocation),P);
    end
    Cs_miso_uu(i)=Cs_sum/length(f);

  
    Cs_sum=0;
    for k3 = 1 : length(f)
      Cs_sum=Cs_sum+cs_miso(H_miso_u(:,:,k3,tapLocation),He_miso_u(:,:,k3,tapLocation),P);
    end
    Cs_miso_u(i)=Cs_sum/length(f);


 
    Cs_sum=0;
    for k3 = 1 : length(f)
      Cs_sum=Cs_sum+cs_miso(H_miso_du(:,:,k3,tapLocation),He_miso_du(:,:,k3,tapLocation),P);
    end
    Cs_miso_du(i)=Cs_sum/length(f);


   
    Cs_sum=0;
    for k3 = 1 : length(f)
      Cs_sum=Cs_sum+cs_mimo221(H_mimo221(:,:,k3,tapLocation),He_mimo221(:,:,k3,tapLocation),P);
    end
    Cs_mimo221(i)=Cs_sum/length(f);


  
    Cs_sum=0;
    for k3 = 1 : length(f)
      Cs_sum=Cs_sum+MIMO222_2T(H_mimo222(:,:,k3,tapLocation),He_mimo222(:,:,k3,tapLocation),P);
    end
    Cs_mimo222(i)=Cs_sum/length(f);
end


plot(SNR,Cs_siso,'k-','LineWidth',2);
hold on;

plot(SNR,Cs_miso_du,'m-','LineWidth',2);
hold on;


plot(SNR,Cs_miso_uu,'g--','LineWidth',2);
hold on;


plot(SNR,Cs_miso_u,'c-.','LineWidth',2);
hold on;


plot(SNR,Cs_mimo221,'b-','LineWidth',2);
hold on;

plot(SNR,Cs_mimo222,'r-','LineWidth',2);
hold on;



grid on;
xlabel('secrecy capacity bit/Hz');
ylabel('Empirical CDF');
legend('SISO','MISO E(N-PE) B(N-P)','MISO E(N-P) B(N-P)','MISO B(N-P)','MIMO221 E(N-PE)','MIMO222');