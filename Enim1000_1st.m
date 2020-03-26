%*************************循环主程序********************************
parpool('local',32); %开启并行池
start_time = datestr(now,'日期yyyy-mm-dd 时间HH:MM:SS');
disp(['程序开始时间：【',start_time,'】']);

addpath('/public1/home/sc40009/jobs/Enim_Total');
%% 第一步读取磁场数据*********
disp('程序开始，读取磁场数据中……');
tic
load('/public1/home/sc40009/jobs/Enim_Total/data_V1031.mat');
disp('data_V1031.mat读取完毕，开始设定参数……');
toc

%% 第二步设定参数初始值*********

v= Cal_V(1000e3);



disp('参数设定完毕，开始循环计算……');

lx = 36; % 0~140，每4mm一个点
ly = 36; % 0~140，每4mm一个点

lphi = 19; % 0°~180°，每10°一个点

lsita = 21; % -20°~20°，每2°一个点

Total = lx*ly*lphi*lsita;%总数
EM1 = zeros(Total,1);% 击中目标区域
EM2 = zeros(Total,1);%无磁场时会打到目标区域的电子
EM3 = zeros(Total,1);%无磁场时会打到目标区域，加上磁场之后也会打到目标区域的电子
EM4 = zeros(Total,1);%无磁场时不会打到目标区域，而加上磁场之后会打到目标区域的电子
EM5 = zeros(Total,1);%无磁场时会打到目标区域，加上磁场之后不会打到目标区域的电子
EMP = zeros(Total,2);%显示落点

parfor k = 1:Total
    [mx,my,mphi,msita] = floopsettings((k - 1),lx,ly,lphi,lsita);
    %*****计算运动******
    P0 = [mx/1000,my/1000,0.055];
    V0 = [v*cos(-(msita/180+90/180)*pi)*sin((mphi/180)*pi), ...
        v*cos(-(msita/180+90/180)*pi)*cos((mphi/180)*pi), ...
        v*sin(-(msita/180+90/180)*pi)];
    
    [P,V,~] = yun_dong(P0,V0,Fx,Fy,Fz);
    
    %*******做判断*********
    [I0,~] = if_without_megnet_field(P0,V0);%没有磁场的时候
    [I,W] = pan_duan_shi_fou_neng_she_dao_ban_zi_shang(P,V);%做判断


    if I
        %disp([nowtime,' ',' 初始速度为 |',num2str(V0), '| 初始位置为 |',num2str(P0), '| ', ' ','穿出速度为 |',num2str(V), '| 穿出位置为 |',num2str(P),'|']);
        EM1(k) = 1;
        % 击中目标区域
    end
    
    %*******显示落点*********
    EMP(k,:) = W;
    
    %*******典型数据记录*********
    if I0
        EM2(k) = 1;
        %无磁场时会打到目标区域的电子
    end
    
    if I0 && I
        EM3(k) = 1;
        %无磁场时会打到目标区域，加上磁场之后也会打到目标区域的电子
    end
    
    if (~I0) && I
        EM4(k) = 1;
        %无磁场时不会打到目标区域，而加上磁场之后会打到目标区域的电子
    end
    
    if I0 && (~I)
        EM5(k) = 1;
        %无磁场时会打到目标区域，加上磁场之后不会打到目标区域的电子
    end

end

end_time = datestr(now,'日期yyyy-mm-dd 时间HH:MM:SS');

%% 总结
fid = fopen('/public1/home/sc40009/jobs/Enim_Total/1000keV_result.txt','w');

disp(['总计算的电子数【',num2str(Total),'】','击中目标区域的电子数【',num2str(sum(EM1)),'】',' 程序开始时间：【',start_time,'】 程序结束时间【',end_time,'】']);
fprintf(fid,['总计算的电子数【',num2str(Total),'】','击中目标区域的电子数【',num2str(sum(EM1)),'】',' 程序开始时间：【',start_time,'】 程序结束时间【',end_time,'】']);

disp(['无磁场时会打到目标区域的电子数【',num2str(sum(EM2)),'】','无磁场时会打到目标区域，加上磁场之后也会打到目标区域的电子数【',num2str(sum(EM3)),'】','无磁场时不会打到目标区域，而加上磁场之后会打到目标区域的电子数【',num2str(sum(EM4)),'】','无磁场时会打到目标区域，加上磁场之后不会打到目标区域的电子数【',num2str(sum(EM5)),'】',]);
fprintf(fid,['无磁场时会打到目标区域的电子数【',num2str(sum(EM2)),'】','无磁场时会打到目标区域，加上磁场之后也会打到目标区域的电子数【',num2str(sum(EM3)),'】','无磁场时不会打到目标区域，而加上磁场之后会打到目标区域的电子数【',num2str(sum(EM4)),'】','无磁场时会打到目标区域，加上磁场之后不会打到目标区域的电子数【',num2str(sum(EM5)),'】',]);
fclose(fid);

save /public1/home/sc40009/jobs/Enim_Total/1000计算结果.mat EM1 EM2 EM3 EM4 EM5

save /public1/home/sc40009/jobs/Enim_Total/1000电子落点.txt EMP