%myRo.m
function roo=myRo(alti)
    %assuming z<11000m
    To = 288.1667; %kelvin
    Po = 101314.628;   %[N/m2]
    Ta = To-(0.006499708)*alti;
    Pa = Po*(1-2.255692257*(10^(-5))*alti)^(5.2561);
    R = 286.99236;
    
    roo = Pa/(R*Ta);
end