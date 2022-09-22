%interpolationPlus.m
function num=interpolationPlus(val,startH,va)

    zero = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1; 0.4340 0.3954 0.3752 0.3617 0.3515 0.3429 0.3359 0.3309 0.3293 0.3700];
    three =[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1; 0.4512 0.4099 0.3885 0.3741 0.3633 0.3542 0.3468 0.3415 0.3398 0.3805]; 
    six = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1; 0.4711 0.4267 0.4036 0.3882 0.3767 0.3670 0.3592 0.3536 0.3519 0.3924];
    h=val+startH;
    
    myZero=0;
    myThree=0;
    
    mach=(va/343);
    
    x=0;
    while 1
        x=x+1;
        if(x>10)
             break;
        end
        if (mach<zero(1,x))
            break;
        end
    end
    
    if(x==1)
            ipOne=0.4340;
            ipTwo=0.4512;
    elseif(x>10)
            ipOne=0.3700;
            ipTwo=0.3805;
    else
            ipOne=((zero(2,x)-zero(2,x-1))/(zero(1,x)-zero(1,x-1)))*(mach-zero(1,x))+zero(2,x);
            ipTwo=((three(2,x)-three(2,x-1))/(three(1,x)-three(1,x-1)))*(mach-three(1,x))+three(2,x);

    end
    num=((ipTwo-ipOne)/(3000-0))*h+ipOne;

    

end
    
    
        

