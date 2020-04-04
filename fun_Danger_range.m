function IF = fun_Danger_range(n,m_phi,m_theta)
%fun_Danger_range - 判断电子摄入角度是不是危险角度
%
% Syntax: IF = fun_Danger_range(k,mark_phi,mark_theta)
%
% Long description

a = m_phi*m_theta/abs(m_theta);
b = 180 - m_theta;
IF = 0;
if n == 1
    if (a >= -180 && a <= -50)||(a >= 170 && a < 180)&&(b >= 165 && b < 180)
        IF = 1;
    end
elseif n == 2
    if (a >= -125 && a <= -70)||(a >= 160 && a < 180)&&(b >= 160 && b < 180)
        IF = 1;
    end
elseif n == 3
    if (a >= -125 && a <= -75)&&(b >= 160 && b < 180)
        IF = 1;
    end
elseif n == 4
    if (a >= -180 && a <= -150)&&(b >= 160 && b < 180)
        IF = 1;
    end
elseif n == 5
    if (a >= -180 && a <= -100)&&(b >= 158 && b < 180)
        IF = 1;
    end
elseif n == 6
    if (a >= -170 && a <= -100)&&(b >= 150 && b < 180)
        IF = 1;
    end
elseif n == 7
    if (a >= -140 && a <= -100)&&(b >= 150 && b < 180)
        IF = 1;
    end
elseif n == 8
    if (a >= -180 && a <= -150)||(a >= 160 && a <= 180)&&(b >= 150 && b < 180)
        IF = 1;
    end
elseif n == 9
    if (a >= -180 && a <= -125)&&(b >= 150 && b < 180)
        IF = 1;
    end
end
end