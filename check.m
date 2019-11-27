function [P0 V0] = check(k,Fx,Fy,Fz)
lx = 166/2 + 1; % 每0.2mm一个点
ly = 166/2 + 1; % 每0.2mm一个点

lphi = 180/2 + 1; % 0°~180°，每2°一个点

lsita = 40/2 + 1; % -20°~20°，每2°一个点
[~,v,OP,~,~] = settings(1);
[mx,my,mphi,msita] = floopsettings(k,lx,ly,lphi,lsita);
P0 = [mx/1000,my/1000,OP(3)];
V0 = [v*cos(-((msita/180)/180+90/180)*pi)*sin((mphi/180)*pi), ...
    v*cos(-((msita/180)/180+90/180)*pi)*cos((mphi/180)*pi), ...
    v*sin(-((msita/180)/180+90/180)*pi)];

[P,V,~] = yun_dong(P0,V0,Fx,Fy,Fz);
P0
V0
P
V

end