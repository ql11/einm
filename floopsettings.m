function [mx,my,mphi,msita] = floopsettings(k,lx,ly,lphi,lsita)
    %将嵌套循环化为统一循环
    if k < lx*ly*lphi*lsita

        mx = floor(k/(ly*lphi*lsita));%0~151
        my = floor(mod(k,(ly*lphi*lsita))/(lphi*lsita));%0~151
        mphi = floor(mod(mod(k,(ly*lphi*lsita)),(lphi*lsita))/lsita);% 0到(lphi-1)/2
        msita = mod(mod(mod(k,(ly*lphi*lsita)),(lphi*lsita)),lsita) - (lsita-1)/2;% -(lsita-1)/2 到 (lsita-1)/2
%         if (msita + 20) + mphi*lsita + (my + (lx-1)/2)*lphi*lsita + (mx + (ly-1)/2)*ly*lphi*lsita == k
%             disp('yes');
%         end
    else 
        disp('循环超出');
        mx = 0;my= 0;mphi= 0;msita= 0;
    end
    
end
