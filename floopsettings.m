function [mx,my,mphi,msita] = floopsettings(k,lx,ly,lphi,lsita)
    %将嵌套循环化为统一循环；排列次序以第三象限的次序为基准
    if k < lx*ly*lphi*lsita

        mx = floor(k/(ly*lphi*lsita));
        my = 120 + floor(mod(k,(ly*lphi*lsita))/(lphi*lsita));
        mphi = 4*floor(mod(mod(k,(ly*lphi*lsita)),(lphi*lsita))/lsita);
        msita = 4*mod(mod(mod(k,(ly*lphi*lsita)),(lphi*lsita)),lsita) - 20;

    else 
        disp('循环超出');
        mx = 0;my= 0;mphi= 0;msita= 0;
    end
    
end
