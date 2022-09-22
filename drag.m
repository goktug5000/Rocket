%drag.m
function dF=drag(ro,v,Cd,A)
    dF=0.5*ro*v*v*Cd*A;
end