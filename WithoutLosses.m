%Economic Load Dispatch  not considering Transmission Losses
clc;
% n a b c min max
data1=[1 300 8.4 0.0025 47 400;
    2 700 7 0.0085 47 400;
    3 350 9 0.0020 49.5 450;];
D=1100; % Total Load
d=data1;
a=d(:,2);
b=d(:,3);
c=d(:,4);
Pl=d(:,5);
Ph=d(:,6);
dP=D;
x=max(b); %Assume Lambda
while abs(dP)>0.00001
    P=(x-b)./c/2;
    P=min(P,Ph);
    P=max(P,Pl);
    dP=D-sum(P);
    x=x+dP*2/(sum(1./c));
end
fprintf('AYAN MONDAL')
fprintf('\nEconomic Load Dispatch without Losses')
C=d(:,2)+b.*P+c.*P.*P; %Costs
totalCost=sum(C)
T=table(d(:,1),P,C,'V',{'UNIT' 'POWER' 'COST'});
disp(T)
