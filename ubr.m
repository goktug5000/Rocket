clc
clear

V =100;
alfa = 70;                  %fýrlatma açýsý
alfa=alfa*pi/180;
Vz = sin(alfa)*V;           %Z eksenindeki hýzý
Vx = cos(alfa)*V;           %X eksenindeki hýzý
deltaT=0.01;                %her adýmdaki zaman deðiþimi

locationZ=[];               %Z eksenindeki konumu
locationZ(1)=0;
locationX=[];               %Z eksenindeki konumu
locationX(1)=0;

t=[];

x=1;
t(1)=0;

tepe=0;
tepeVz=0;
tepeVx=0;
tepeT=0;
c=[];
ucusYoluAcisi=[];

while 1 
    x=x+1;
    t(x)=t(x-1)+deltaT;
    locationZ(x)=Vz*deltaT+locationZ(x-1); 

    Vz=Vz-(9.81*deltaT);  
    locationX(x)=Vx*deltaT+locationX(x-1); 
        
    if(locationZ(x)>tepe)
        tepe=locationZ(x);
        tepeVz=Vz;
        tepeVx=Vx;
        tepeT=t(x);
    end
    
    
    
    c(x)=atan(Vz/Vx);
    ucusYoluAcisi(x)=c(x)*57.2958;
    
    
    
    if (locationZ(x)<=0)
        sonNokta=locationX(x);
        break;
    end
end

figure;
scatter(locationX,locationZ,'.')
xlabel('Menzil [m]') 
ylabel('Yükseklik') 
title(['Tepe noktasý ',num2str(tepe),'[m]'])


figure;
scatter(t,ucusYoluAcisi,'.')
xlabel('Zaman (t)') 
ylabel('Uçuþ Yolu Açýsý') 
title('Uçuþ Yolu Açýþý - Zaman')


disp ('Tepe Noktasý Yüksekliði [m]')
disp (tepe)
disp ('Tepe Noktasý Hýzý (bileþke) [m/s]')
Vbileske = (tepeVz^2+tepeVx^2)^(1/2);
disp (Vbileske)
disp ('Tepe Noktasý Zamaný [s]')
disp (tepeT)

disp ('Son Pozisyon [m] [-, 0, 0]')
disp (num2str(sonNokta))

VbileskeSon = (Vz^2+Vx^2)^(1/2);
disp ('Son Hýz (bileþke) [m/s]')
disp (VbileskeSon)


disp ('Son Uçuþ Yolu Açýsý [derece]')
disp (ucusYoluAcisi(x))

disp ('Son Uçuþ Zamaný [s]')
disp (t(x))
