%havaYogunluk.m
%havan�n yo�unlu�unun metreye g�re bulundu�u k�s�m
clc
clear

ro=[];
c=[];
for a=1:10000
    ro(a)=myRo(a);
    c(a)=a;
end

figure;
scatter(c,ro,'.')
xlabel('y�kseklik') 
ylabel('Hava Yo�unlu�u') 
title('Hava Yo�unlu�u/y�kseklik')