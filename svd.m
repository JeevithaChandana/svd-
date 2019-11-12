clc;clear;close all;
[s,fs]=audioread('sp01_airport_sn15.wav');
N=length(s);
u=audioread('sp01.wav');
%%
frames=frame_sig(s,3000,1500,@hamming);
frames1=frames';
 %%
for r1=1:15
    H=hankel(frames1(:,r1));
    [U,S,V]=svd(H);
k=diag(S);
plot(k);
%%
for i=1:length(frames1(:,1))
    if(i<=1000)
        S1(i,i)=S(i,i);
    else
        S1(i,i)=0;
    end
end

%%
A=(U*S1)*V';
%%
for i=2:length(frames1(:,1))
    k=i;
    j=1;
    r=0;
    y1(1)=A(1,1);
    while(k>0)
    
        y1(i)=(r+A(k,j));
        r=A(k,j);
        k=k-1;
        j=j+1;
     
    end
    y1(i)=y1(i)/2;
end
    H1(:,r1)=y1';
    fprintf('%d',r1);
end
A=deframe_sig(H1',N,3000,1500,@hamming);
%%
k1=snr(u,A);
%%
audiowrite('sp01_airport_sn15_output.wav',A',fs)
h1='sp01_airport_sn15_output.wav';
x1='sp01.wav';
[a,b,c]=composite1(x1,h1);
disp(a);
disp(b);
disp(c);
%%
plot(s);
hold on
plot(A);
