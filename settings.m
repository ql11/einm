function [MFA,v,P0,TA,dt]=settings(E)
%集合了所有设置
    MFA = [0.140 0.140 0.055];%磁场范围 280*280*110
    v = Cal_V(E);%速度大小
    P0 = [0.05 0.05 0.05499];%初始位置
    TA = [0.0705 0.0705];%目标区域
    dt = 1e-4/v;%时间间隔(0.1mm)
end
