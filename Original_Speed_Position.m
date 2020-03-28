
function [P0,V0] = Original_Speed_Position(k)
%Original_Speed_Position - 输入电子序号，输出初始速度和位置
%
% Syntax: [P0,V0] = Original_Speed_Position(input)
%
% Long description
    


v= Cal_V(1000e3);%速度大小Cal_V()

lx = 50; % 0~49，每1mm一个点
ly = 20; % 120~139，每1mm一个点
lphi = 46; % 0°~180°，每4°一个点
lsita = 11; % -20°~20°，每4°一个点

[mx,my,mphi,msita] = floopsettings((k - 1),lx,ly,lphi,lsita);
%*****计算运动******
P0 = [(mx/120)*0.120,(my/120)*0.120,0.055];
V0 = [v*cos(-((msita/180)/180+90/180)*pi)*sin((mphi/180)*pi), ...
    v*cos(-((msita/180)/180+90/180)*pi)*cos((mphi/180)*pi), ...
    v*sin(-((msita/180)/180+90/180)*pi)];
end