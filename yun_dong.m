function [P,V,pic] = yun_dong(P0,V0,Fx,Fy,Fz)

if length(P0) ~= 3 || length(V0) ~= 3 %例行判断参数
    disp('运动计算错误：输入的不是坐标或矢量');
    P = [0 0 0];
    V = [0 0 0];
    pic = P0;
    return
else
    P1 = P0;
    P2 = P1;
    pic = P0;%画图用
    V1 = V0;
    V2 = V1;
    [~,~,~,~,dt]= settings(1);%时间间隔
    if ci_chang_fan_wei(P1) == 1
        for k = 1:30000 %最多运动3000mm
            if  ci_chang_fan_wei(P1)
                P1 = P2+dt.*V1;%新位置
                V1 = su_du(P2,V2,Fx,Fy,Fz);%求出新速度
                P2 = P1;%更新位置
                V2 = V1;%更新速度
            else
%                 disp('已经穿出磁场');
                P = P1;
                V = V1;
                return
            end

        end
        disp('循环次数不够');
        P = P1;
        V = V1;
    else
        disp('Not in MFA');
        P = P1;
        V = V1;
    end
 
end

end
