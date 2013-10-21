function cs=pureCapacity(h,P)
f=size(h,3);
indexLambda=min(size(h,1),size(h,2));

tmp=0;
for i1=1 : length(f)
    [U,S,V]=svd(h(:,:,f));
    for i2= 1 : indexLambda
        tmp=tmp+log2(1+P*S(i2,i2)^2/indexLambda);
    end
end
  
cs=max(tmp,0);

end