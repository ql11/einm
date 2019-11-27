function [MFA,v,P0,TA,dt]=settings(I)
%集合了所有设置
if I == 1
    MFA = [0.0167 0.0167 0.035];%磁场上边界 33.4*33.4*35
    v = Cal_V(25000);%速度大小25keV
    P0 = [0.0167 0.0167 0.0349];%初始位置
    TA = [0.016 0.016];%目标区域
    dt = 1e-4/v;%时间间隔(0.1mm)
else
    disp('settings error');
end
end
