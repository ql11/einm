
start_time = datestr(now,' yyyy-mm-dd HH:MM:SS');
disp([' Program Start Time：【',start_time,'】']);

disp('Program start，magnetfield data loading……');

% tic
% load('B_Vector_1022_design2.mat');
% disp('magnetfield data complete，config setting……');
% toc
[MFA,~,~,~,~]=settings(1);

N = 10000;
k = MFA(1)*10000;
[x,y]=meshgrid(-MFA(1):(1/N):MFA(1));
z = zeros(2*k+1,2*k+1);



F = sqrt(Fx(x,y,z).^2 + Fy(x,y,z).^2 + Fz(x,y,z).^2);


mesh(x,y,F);
axis([-0.15 0.15 -0.15 0.15 -1 2]);