%ubrKRE.m
%KTR AÞAMASINDAKÝ UBR RAPORUNUN ANA KODU
clc
clear


myImpulse=readtable('veri_itki_F_2022_w0T8e.csv');  %veri_itki_F_2022_w0T8e imported


V=[];
V(1) =2;
M=[];
M(1)=28.08;
massF=[];
massF(1)=0;

isp=209.5;
teta=[];
teta = 85;                     %fýrlatma açýsý
teta=teta*pi/180;

Vz=[];
Vz(1) = sin(teta)*V;           %Z eksenindeki hýzý
Vx=[];
Vx(1) = cos(teta)*V;           %X eksenindeki hýzý
deltaT=0.01;                      %her adýmdaki zaman deðiþimi



Fz=0;
Fx=0;
imp=[];
imp(1)=0;
g=9.801;

t=[];

x=1;
t(1)=0;

tepe=0;
tepeVz=0;
tepeVx=0;
tepeT=0;
c=[];
ucusYoluAcisi=[];

az=[];
ax=[];
az(1)=0;                       %z eksenindeki ivme
ax(1)=0;                       %x eksenindeki ivme

ro=[];
ro(1)=1;
Cd=[];
Cd(1)=0.35;
cap=0.12;
A=(cap/2)*(cap/2)*pi;

baslangicH=980;
zero = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1; 0.4340 0.3954 0.3752 0.3617 0.3515 0.3429 0.3359 0.3309 0.3293 0.3700];
three =[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1; 0.4512 0.4099 0.3885 0.3741 0.3633 0.3542 0.3468 0.3415 0.3398 0.3805]; 
six = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1; 0.4711 0.4267 0.4036 0.3882 0.3767 0.3670 0.3592 0.3536 0.3519 0.3924];

ultimateAraBool=0;


locationZ=[];                  %Z eksenindeki konumu
locationZ(1)=baslangicH;
locationX=[];                  %X eksenindeki konumu
locationX(1)=0;

allTetas=[];
speedMach=[];

while 1 

    allTetas(x)=teta*57.2958;
    speedMach(x)=V(x)/343;

    x=x+1;
    t(x)=t(x-1)+deltaT;
    
    araBool=1;
    if(ultimateAraBool==1)
        
        araBool=0;
    end

    y=0;
    while araBool
        y=y+1;
        %disp(myImpulse{y,1})
        
        a=myImpulse{y,1};
        newChr = strrep(a,',','.');
        fakeTime=str2double(newChr);
    %    disp("t: "+t(x)+" fakeTime: "+fakeTime + " t-fakeTime: "+(t(x)-fakeTime))
        if((t(x)-fakeTime)<deltaT)
         %   disp("oldu ve y="+y)
            araBool=0;
        end
    end
    
    if(ultimateAraBool==0)
            aa=myImpulse{y,2};
            newChr = strrep(aa,',','.');
            impAra=str2double(newChr);

            M(x)=M(x-1)-massFlow(isp,impAra*deltaT,g);
            massF(x)=massFlow(isp,impAra*deltaT,g);
            imp(x)=impAra;
            
            %disp("M(x) "+M(x)+" mF: "+massFlow(isp,impAra*deltaT,g))
    else
            massF(x)=0;
            M(x)=M(x-1);
            imp(x)=0;
    end

    %disp("M(x) "+M(x))
    
    if(massFlow(isp,impAra*deltaT,g)==0)
        ultimateAraBool=1;
    end

    
    


    %ro hesaplanýr
    ro(x)=myRo(locationZ(x-1));
    %Cd hesaplanýr 
    %Cd(x)=interpolationPlus(locationZ(x-1),baslangicH,V(x-1));
    Cd(x)=0.34;
    
    

    Fz = (sin(teta)*(imp(x)+imp(x-1))/2)-(sin(teta)*drag(ro(x),V(x-1),Cd(x),A));
    Fx = (cos(teta)*(imp(x)+imp(x-1))/2)-(cos(teta)*drag(ro(x),V(x-1),Cd(x),A));

    
    az(x)=Fz/M(x)-g;
    ax(x)=Fx/M(x);
    
    Vz(x)=Vz(x-1)+((az(x)+az(x-1))/2)*deltaT;
    Vx(x)=Vx(x-1)+((ax(x)+ax(x-1))/2)*deltaT;
    V(x)=((Vz(x)*Vz(x))+(Vx(x)*Vx(x)))^(1/2);

    
    locationZ(x)=locationZ(x-1)+((Vz(x)+Vz(x-1))/2)*deltaT;
    locationX(x)=locationX(x-1)+((Vx(x)+Vx(x-1))/2)*deltaT;


    teta=atan(Vz(x)*Vx(x));
    
    
    if (locationZ(x)<=locationZ(x-1))
        speedMach(x)=V(x)/343;
        allTetas(x)=teta*57.2958;
        break;
    end
    
end



figure;
scatter(locationX,locationZ,'.')
xlabel('Menzil [m]') 
ylabel('Yükseklik') 
title(['Tepe noktasý ',num2str(locationZ(x)),'[m]'])

figure;
scatter(t,imp,'.')
xlabel('t') 
ylabel('impulse [N]') 
title('impulse/t')

figure;
scatter(t,Vz,'.')
xlabel('t') 
ylabel('Vz [m/s]') 
title('Vz/t')

figure;
scatter(t,massF,'.')
xlabel('t') 
ylabel('mass flow rate [kg/s]') 
title('mass flow rate/t')

figure;
scatter(t,M,'.')
xlabel('t') 
ylabel('Kalan Kütle [kg]') 
title('Kalan Kütle/t')


figure;
scatter(t,allTetas,'.')
xlabel('t') 
ylabel('Uçuþ yolu açýsý [derece]') 
title('Uçuþ yolu açýsý/t')

figure;
scatter(t,speedMach,'.')
xlabel('t') 
ylabel('Mach') 
title('Mach/t')

figure;
scatter(t,ro,'.')
xlabel('t') 
ylabel('Dinamik basýnç') 
title('Dinamik basýnç/t')

figure;
scatter(t,Vz,'.')
xlabel('t') 
ylabel('Dikey týrmanma hýzý [m/s]') 
title('Dikey týrmanma hýzý/t')