function m = mfbank(p,n,fs)
%clc;
%clear all;
%p=20;
%fs=44100;
%n=256;
f1=0;
f2=fs/2;
m1=1125*log(1+f1/700);
m2=1125*log(1+f2/700);
P=p;
delm=(m2-m1)/(P+1);
m=m1:delm:m2;
h=700*(exp(m/1125)-1);
nfft=n;
%fs=44100;
f = floor((nfft)*h/fs);
for i=1:P
    for k=0:f(length(f))
    if (k<f(i))
        H(i,k+1)=0;
    end
    if(k>=f(i)&&k<=f(i+1))
        H(i,k+1)=(k-f(i))/(f(i+1)-f(i));
    end
    if(k>=f(i+1)&&k<=f(i+2))
        H(i,k+1)=(f(i+2)-k)/(f(i+2)-f(i+1));
    end
    end
end
%plot(1:256,H(:,1),1:256,H(:,2),1:256,H(:,3),1:256,H(:,4),1:256,H(:,5),1:256,H(:,6),1:256,H(:,7),1:256,H(:,8),1:256,H(:,9),1:256,H(:,10));
        
%plot(1:f(length(f)),H(:,:));  
m=H;