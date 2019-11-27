function [I,W] = pan_duan_shi_fou_neng_she_dao_ban_zi_shang(P,V)
%电子经过磁场后，是否能射到板子上呢，是输出真

%Fanwei = [0.131 0.131 0.015];%这个是设定的磁场范围，可以放进自变量
[~,v,~,Q,~]=settings(1);
if length(V) ~= 3
    disp('输入错误，不是速度矢量');
    I = 1==0; %输出假
    W = [111 111];
    return
%elseif V(3) >= 0 %z方向速度为向上
%    I = 1==0; %输出假
%    W = [222 222];
%    return
elseif -0.0005 < P(3) && P(3)<  0.0005 %射出位置在z = 0表面
%开始判断
    absP = abs(P);
    if absP(1)< Q(1) && absP(2)< Q(2)

        I = 1==1;%输出真
    else
        I = 1==0;
    end

    W(1) = P(1);
    W(2) = P(2);
elseif P(3) >  0.0005
    I = 1==0; %输出假
    W(1) = P(1) + V(1)*(P(3)/v);
    W(2) = P(2) + V(2)*(P(3)/v);
else
    W(1) = 333;
    W(2) = 333;
end
end