function v = Cal_V(Ek)
% 输入电子动能Ek = 0.5*m*v^2，单位eV，输出电子速率和相对论质量
c = 3e8;%光速
%E0 = 0.511001e6;%电子静止能量m0*c^2，单位eV。这个极其不准
%m0 = E0/c^2;    %电子静止质量，单位eV*s^2/m^2
m0 = 9.10938215e-31/1.602176565e-19;%电子静止质量，单位eV*s^2/m^2
%解方程
%令x = (v/c)^2;
TEM = (2*Ek/(m0*c^2))^2;
%x^2/(1-x) = TEM => x^2 + TEM*x - TEM = 0
x = (-TEM + sqrt((TEM^2 + 4*TEM)))/2;%x = (-b + sqrt(b^2 - 4ac))/2a
v = c*sqrt(x);
end
