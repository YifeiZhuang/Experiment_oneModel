%% this .m for secrecy capacity over length
%% with frequency selective impedances
%% with a random cable length distribution
%% test 222 case
%% differences with the 221 case; 1.change load .mat file 2. change cM, 3.change Cs in 2 places to avoid covering


f = 1e5:1e5:80e6;

cond1 = load('3Cond_Symmetric_T.mat'); %first line (TX)

cond2 = load('3Cond_Symmetric_T.mat'); %second line (RX)

condb = load('3Cond_Symmetric_T.mat'); %branch line

load_fs = load('FSZ_80mhz.mat');

%determine number of conductors
NCond1 = size(cond1.C, 1) + 1;
NCond2 = size(cond2.C, 1) + 1;
NCondb = size(condb.C, 1) + 1;

%admittance matrices, for every frequency
Y1 = zeros(NCond1-1, NCond1-1, length(f));
Y2 = zeros(NCond2-1, NCond2-1, length(f));
Yb = zeros(NCondb-1, NCondb-1, length(f));
%impedance matrices, for every frequency
Z1 = zeros(size(Y1));
Z2 = zeros(size(Y2));
Zb = zeros(size(Yb));

%{
H2=zeros(NCond2-1, NCond2-1, length(f));
Hb=zeros(NCondb-1, NCondb-1, length(f));
H1=zeros(NCond1-1, NCond1-1, length(f));
H=zeros(NCond1-1, NCond2-1, length(f));
He=zeros(NCondb-1, NCond1-1, length(f));%% size= N_receive * N_transmit

%%Yr2=Connect2*Yr2
Yr2=zeros(NCond2-1, NCond2-1, length(f));
Yrb= zeros(NCondb-1, NCondb-1, length(f));
Yr1= zeros(NCond1-1, NCond1-1, length(f));
%}

for k2 = 1:length(f)
    
    omega = 2*pi*f(k2);
    
    Z1(:,:,k2) = cond1.R(:,:, k2) + 1i*cond1.L*omega;
    Z2(:,:,k2) = cond2.R(:,:, k2) + 1i*cond2.L*omega;
    Zb(:,:,k2) = condb.R(:,:, k2) + 1i*condb.L*omega;
    Y1(:,:,k2) = cond1.G(:,:, k2) + 1i*cond1.C*omega;
    Y2(:,:,k2) = cond2.G(:,:, k2) + 1i*cond2.C*omega;
    Yb(:,:,k2) = condb.G(:,:, k2) + 1i*condb.C*omega;    
end



%% frequency selective load impedance=load origin+load plc



Y_L2=zeros(NCond2-1,NCond2-1,length(f));
Y_Lb=zeros(NCondb-1,NCondb-1,length(f));




%% length
lenb=3.3;
len1=4.5;
len2=5.5;
testN=100;

P=10^(15/10);%15dB
HPosition=zeros(NCond2-1,NCond1-1,length(f),testN);
HePosition=zeros(NCondb-1,NCond1-1,length(f),testN);
%% generate testN 
for i=1: testN
var_plc_y=1/(10*i);
    
Y_L2_PLC=[var_plc_y,0;0,var_plc_y];
Y_Lb_PLC=[var_plc_y,0;0,var_plc_y];
  
Y_L2(1,1,:)=load_fs.Load(1,:,:)+Y_L2_PLC(1,1)*zeros(1,1,length(f));
Y_L2(1,2,:)=load_fs.Load(2,:,:)+Y_L2_PLC(1,2)*zeros(1,1,length(f));
Y_L2(2,1,:)=load_fs.Load(2,:,:)+Y_L2_PLC(2,1)*zeros(1,1,length(f));
Y_L2(2,2,:)=load_fs.Load(3,:,:)+Y_L2_PLC(2,2)*zeros(1,1,length(f));
Y_Lb(1,1,:)=load_fs.Load(4,:,:)+Y_Lb_PLC(1,1)*zeros(1,1,length(f));
Y_Lb(1,2,:)=load_fs.Load(5,:,:)+Y_Lb_PLC(1,1)*zeros(1,1,length(f));
Y_Lb(2,1,:)=load_fs.Load(5,:,:)+Y_Lb_PLC(1,1)*zeros(1,1,length(f));
Y_Lb(2,2,:)=load_fs.Load(6,:,:)+Y_Lb_PLC(1,1)*zeros(1,1,length(f));
    
    [HPosition(:,:,:,i),HePosition(:,:,:,i)]=TF_222(f,Y1,Z1,len1,Y2,Z2,len2,Y_L2,Yb,Zb,lenb,Y_Lb);
 
end
save('data_H_PLCY','HPosition','HePosition');