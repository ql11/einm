function IF = fun_Danger_range(k,P_V)
%fun_Danger_range - 判断电子摄入角度是不是危险角度
%
% Syntax: IF = fun_Danger_range(k,P_V)
%
% Long description

a = P_V(3);
b = P_V(4);
IF = 0;
if k == 1
    if (a >= -180 && a <= -50)||(a >= 170 && a <= 180)&&(b >= 165 && b <= 180)
        IF = 1;
    end
elseif k == 2
    if (a >= -125 && a <= -70)||(a >= 160 && a <= 180)&&(b >= 160 && b <= 180)
        IF = 1;
    end
elseif k == 3
    if (a >= -125 && a <= -75)&&(b >= 160 && b <= 180)
        IF = 1;
    end
elseif k == 4
    if (a >= -180 && a <= -150)&&(b >= 160 && b <= 180)
        IF = 1;
    end
elseif k == 5
    if (a >= -180 && a <= -100)&&(b >= 158 && b <= 180)
        IF = 1;
    end
elseif k == 6
    if (a >= -170 && a <= -100)&&(b >= 150 && b <= 180)
        IF = 1;
    end
elseif k == 7
    if (a >= -140 && a <= -100)&&(b >= 150 && b <= 180)
        IF = 1;
    end
elseif k == 8
    if (a >= -180 && a <= -150)||(a >= 160 && a <= 180)&&(b >= 150 && b <= 180)
        IF = 1;
    end
elseif k == 9
    if (a >= -180 && a <= -125)&&(b >= 150 && b <= 180)
        IF = 1;
    end
end
end