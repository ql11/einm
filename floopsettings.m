function [mx,my,mphi,msita] = floopsettings(k,lx,ly,lphi,lsita)
    %将嵌套循环化为统一循环；排列次序以第三象限的次序为基准


    Total = lx*ly*lphi*lsita;
    [MFA,~,~,~,~]=settings(1);
    dx = MFA(1)*1000/(lx - 1);%距离间隔，单位mm
    dy = MFA(1)*1000/(ly - 1);%距离间隔，单位mm
    dphi = 180/(lphi - 1);%角度间隔，单位度
    dsita = 40/(lsita - 1);%角度间隔，单位度
    if k < Total

        mx = MFA(1)*1000 - dx*floor(k/(ly*lphi*lsita));
        my = MFA(2)*1000 - dy*floor(mod(k,(ly*lphi*lsita))/(lphi*lsita));
        mphi = dphi*floor(mod(mod(k,(ly*lphi*lsita)),(lphi*lsita))/lsita);
        msita = dsita*mod(mod(mod(k,(ly*lphi*lsita)),(lphi*lsita)),lsita) - 20;

    else 
        disp('循环超出');
        mx = 0;my= 0;mphi= 0;msita= 0;
    end
    
end
