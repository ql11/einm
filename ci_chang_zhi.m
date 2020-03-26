function B = ci_chang_zhi(P,Fx,Fy,Fz)
%输入位置，返回磁场大小。20180912改了磁场值全部为零
if length(P) ~= 3
    disp('磁场值错误：输入的不是坐标');
    B = [0 0 0];
    return
else
    if ci_chang_fan_wei(P)%如果在磁场范围内
        %现在开始给磁场赋值
%         global absP    
%         B(1) = evalin('base','Fx(absP)');
%         B(2) = evalin('base','Fy(absP)');
%         B(3) = evalin('base','Fz(absP)');
%         B(1) = 0;
%         B(2) = 0;
%         B(3) = 0;

        B = [Fx(P) Fy(P) Fz(P)];
        
        
%         if P(1)>= 0 && P(2) >= 0 %第一象限
%             return
%         elseif P(1) < 0 && P(2) >= 0 %第二象限，相对第一象限以y轴对称
%             B(1) = -B(1);
%             
%         elseif P(1) < 0 && P(2) < 0 %第三象限，相对第一象限以原点对称
%             B(1) = -B(1);
%             B(2) = -B(1);
%             
%         else %第四象限，相对第一象限以x轴对称
%             B(2) = -(2);
%             
%         end
        
    else
        B = [0 0 0];
    end
end

end