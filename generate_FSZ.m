%function Load=generate_FSZ(f)
f=1e5:1e5:80e6;

Load=zeros(6,1,length(f));
for i = 1 : 6
FSZ=zeros(1,length(f));
w0=2*pi*random('Uniform',2,28)*1e6;
R=random('Uniform',200,1800);
Q=random('Uniform',5,25);

for ii=1:length(f)
         w=2*pi*f(ii);
         FSZ(ii)=R/(1+j*Q*(w/w0-w0/w));
         FSZ(ii)=1/FSZ(ii);
end

Load(i,:,:)=FSZ;
end
save('FSZ_80mhz.mat','Load');

%end