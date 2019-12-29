function [MFA,v,P0,TA,dt]=settings(I)
%集合了所有设置
if I == 1
    MFA = [0.151 0.151 0.03];%磁场范围
    v = Cal_V(10000);%速度大小
    P0 = [0.151 0.151 0.01999];%初始位置
    TA = [0.015 0.015];%目标区域
    dt = 1e-4/v;%时间间隔
else
    disp('settings error');
end
end
