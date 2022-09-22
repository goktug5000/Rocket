%havaYogunluk.m
%havanýn yoðunluðunun metreye göre bulunduðu kýsým
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
xlabel('yükseklik') 
ylabel('Hava Yoðunluðu') 
title('Hava Yoðunluðu/yükseklik')