function [IF,mx,my,mz,mphi,msita] = floopsettings(k,~,ly,lphi,lsita)
    %将嵌套循环化为统一循环；排列次序以第三象限的次序为基准

    mx = floor(k/(ly*lphi*lsita));
    my = floor(mod(k,(ly*lphi*lsita))/(lphi*lsita));

    if mx <= 47
        if my <= 47
            n = 1;
        elseif my <= 2*47
            n = 2;
        else
            n = 3;
        end
    elseif mx <= 2*47
        if my <= 47
            n = 4;
        elseif my <= 2*47
            n = 5;
        else
            n = 6;
        end
    else
        if my <= 47
            n = 7;
        elseif my <= 2*47
            n = 8;
        else
            n = 9;
        end
    end

    %判断是否在目标区域，是否需要计算
    

    Special_z =[40.1 37.8 32.9 37.8	35.5 30.6 32.9 30.6	25.7];
    mz = Special_z(n);
    mphi = floor(mod(mod(k,(ly*lphi*lsita)),(lphi*lsita))/lsita);
    msita = mod(mod(mod(k,(ly*lphi*lsita)),(lphi*lsita)),lsita) - 20;

    IF = fun_Danger_range(n,mphi,msita);
end
