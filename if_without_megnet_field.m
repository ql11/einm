function [I,W] = if_without_megnet_field(P,V)
    %无磁场的情况下，是否能射到板子上呢，是输出真
    
    %Fanwei = [0.131 0.131 0.015];%这个是设定的磁场范围，可以放进自变量
    
    if length(V) ~= 3
        disp('输入错误，不是速度矢量');
        I = 1==0; %输出假
        W = [1 1];
        return
    elseif V(3) >= 0 %z方向速度为向上
        I = 1==0; %输出假
        W = [2 2];
        return
    else
    %开始判断
        [~,~,~,Q,~]=settings(1);%Q = [0.0705 0.0705];
        vz = abs(V(3));
        t = (330.5e-3 + P(3))/vz;%时间
        W(1) = P(1) + t*V(1);
        W(2) = P(2) + t*V(2);%输出落点
        
        Pxy(1) = abs(W(1));
        Pxy(2) = abs(W(2));%计算落点绝对值
       
        I = Pxy(1) <= Q(1) & Pxy(2)<= Q(2); %判断位置
    
    end