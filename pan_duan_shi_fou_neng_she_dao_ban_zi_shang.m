function [I,W] = pan_duan_shi_fou_neng_she_dao_ban_zi_shang(P,V)
%电子经过磁场后，是否能射到板子上呢，是输出真

%Fanwei = [0.131 0.131 0.015];%这个是设定的磁场范围，可以放进自变量

if length(V) ~= 3
    disp('输入错误，不是速度矢量');
    I = 1==0; %输出假
    W = [1 1];
    return
elseif V(3) >= 0 %z方向速度为向上
    I = 1==0; %输出假
    W = [1 1];
    return
elseif -0.031<P(3)&& P(3)<= -0.03 %射出位置在z = -30表面
%开始判断
    
    [~,~,~,Q,~]=settings(1);
    vz = abs(V(3));
    t = 1.12/vz;%时间
    Pxy = [P(1) P(2)];
    Pxy(1) = Pxy(1) + t*V(1);
    Pxy(2) = Pxy(2) + t*V(2);%计算落点
    if Pxy(1)> -Q(1) && Pxy(1)< Q(1) && Pxy(2)>-Q(2) && Pxy(2)< Q(2)
        I = 1==1;%输出真
    else
        I = 1==0;
    end
    W(1) = Pxy(1);
    W(2) = Pxy(2);
else
    I = 1==0; %输出假
    W = [1 1];
end
end