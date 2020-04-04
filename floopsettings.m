function [IF,mx,my,mz,mphi,msita] = floopsettings(k,~,ly,lphi,lsita)
    %将嵌套循环化为统一循环；排列次序以第三象限的次序为基准

    mx = floor(k/(ly*lphi*lsita));
    my = floor(mod(k,(ly*lphi*lsita))/(lphi*lsita));

    if mx <= n47
        if my <= n47
            n = 1;
        elseif my <= 2*n47
            n = 2;
        else
            n = 3;
        end
    elseif mx <= 2*n47
        if my <= n47
            n = 4;
        elseif my <= 2*n47
            n = 5;
        else
            n = 6;
        end
    else
        if my <= n47
            n = 7;
        elseif my <= 2*n47
            n = 8;
        else
            n = 9;
        end
    end

    %判断是否在目标区域，是否需要计算
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

    if IF == 1
        Special_z =[40.1 37.8 32.9 37.8	35.5 30.6 32.9 30.6	25.7];
        mz = Special_z(n);
        mphi = floor(mod(mod(k,(ly*lphi*lsita)),(lphi*lsita))/lsita);
        msita = mod(mod(mod(k,(ly*lphi*lsita)),(lphi*lsita)),lsita) - 20;
    else
        mz = 0;
        mphi = 0;
        msita = 0;
    end



    
end
