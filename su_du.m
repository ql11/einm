function V1 = su_du(P,V0,Fx,Fy,Fz)
%输入位置和速度，返回下一个时刻的速度
if length(P) ~= 3 || length(V0) ~= 3 %例行判断参数
    disp('加速度计算错误：输入的不是坐标或矢量');
    V1 = [];
    return
else
    v = norm(V0);%速度绝对值
    c = 3e8;%光速
    m = 9.109382e-12./sqrt(1 - v^2/c^2);%狭义相对论质量*10e19
    dt = fun_dt(0)/v;%时间间隔 1mm 所花的时间
    B = ci_chang_zhi(P,Fx,Fy,Fz);%磁场值
    q = -1.60217662;%电荷量*10e19
    F = q.*cross(V0,B);  %受力
    a = F/m;%加速度
%     if abs(dot(V0,a))<= 1e-3
%         V1 = V0 + dt.*a;
%        
%     else
%         disp('加速度计算错误,不垂直');
        V2 = V0 + dt.*a;
        GUI = norm(V0)/norm(V2);
        V1 = GUI.*V2;
%          abs(dot(V0,a))
%         return
%     end
end

end
