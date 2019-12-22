%绘制z = 0平面的磁场值大小图

start_time = datestr(now,' 日期yyyy-mm-dd 时间HH:MM:SS');
disp([' 程序开始时间：【',start_time,'】']);

disp(['程序开始，读取磁场数据中……']);
%*******第一步读取磁场数据*********
% tic
% load('0110_V.mat');
% disp(['0110_V.mat读取完毕，开始设定参数……']);
% toc

k = 200;
[x,y]=meshgrid(-k/1000:0.001:k/1000); %生成网格坐标
z = zeros(2*k+1,2*k+1);



F = sqrt(Fx(x,y,z).^2 + Fy(x,y,z).^2 + Fz(x,y,z).^2);


mesh(x,y,F);
axis([-0.2 0.2 -0.2 0.2 -1 2]);