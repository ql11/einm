function B = ci_chang_zhi(P,Fx,Fy,Fz)
%输入位置，返回磁场大小。20180912改了磁场值全部为零
if length(P) ~= 3
    disp('磁场值错误：输入的不是坐标');
    B = [0 0 0];
    return
else
    if ci_chang_fan_wei(P)%如果在磁场范围内

        B = [Fx(P) Fy(P) Fz(P)];
    
    else
        B = [0 0 0];
    end
end

end