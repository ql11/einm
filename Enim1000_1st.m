%*************************循环主程序********************************
parpool('local',32); %开启并行池
start_time = datestr(now,'日期yyyy-mm-dd 时间HH:MM:SS');
disp(['程序开始时间：【',start_time,'】']);

work_path = '/public1/home/sc40009/jobs/140x140_Special';
addpath(work_path);
%% 第一步读取磁场数据*********
disp('程序开始，读取磁场数据中……');
tic
load('/public1/home/sc40009/jobs/Enim_Total/data_V1031.mat');
disp('data_V1031.mat读取完毕，开始设定参数……');
toc

%% 第二步设定参数初始值*********
Ek = 1000e3; %todo
v= Cal_V(Ek);



disp('参数设定完毕，开始循环计算……');

lx = 142; % 0~141，每1mm一个点
ly = 142; % 0~141，每1mm一个点
Total = lx*ly;%总数

EM1 = zeros(Total,1);% 击中目标区域
EM2 = zeros(Total,1);%无磁场时会打到目标区域的电子
EM3 = zeros(Total,1);%无磁场时会打到目标区域，加上磁场之后也会打到目标区域的电子
EM4 = zeros(Total,1);%无磁场时不会打到目标区域，而加上磁场之后会打到目标区域的电子
EM5 = zeros(Total,1);%无磁场时会打到目标区域，加上磁场之后不会打到目标区域的电子
EMP = zeros(Total,2);%显示落点

parfor k = 1:Total
    [mx,my,mz,mphi,msita] = floopsettings(k,lx,ly);
    %*****计算运动******
    P0 = [mx/1000,my/1000,mz/1000];
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
fid = fopen([work_path,'/',num2str(Ek/1000),'keV结果概览.txt'],'w');

disp(['总计算的电子数【',num2str(Total),'】','击中目标区域的电子数【',num2str(sum(EM1)),'】',' 程序开始时间：【',start_time,'】 程序结束时间【',end_time,'】']);
fprintf(fid,['总计算的电子数【',num2str(Total),'】','击中目标区域的电子数【',num2str(sum(EM1)),'】',' 程序开始时间：【',start_time,'】 程序结束时间【',end_time,'】']);

disp(['无磁场时会打到目标区域的电子数【',num2str(sum(EM2)),'】','无磁场时会打到目标区域，加上磁场之后也会打到目标区域的电子数【',num2str(sum(EM3)),'】','无磁场时不会打到目标区域，而加上磁场之后会打到目标区域的电子数【',num2str(sum(EM4)),'】','无磁场时会打到目标区域，加上磁场之后不会打到目标区域的电子数【',num2str(sum(EM5)),'】',]);
fprintf(fid,['无磁场时会打到目标区域的电子数【',num2str(sum(EM2)),'】','无磁场时会打到目标区域，加上磁场之后也会打到目标区域的电子数【',num2str(sum(EM3)),'】','无磁场时不会打到目标区域，而加上磁场之后会打到目标区域的电子数【',num2str(sum(EM4)),'】','无磁场时会打到目标区域，加上磁场之后不会打到目标区域的电子数【',num2str(sum(EM5)),'】',]);
fclose(fid);

save([work_path,'/',num2str(Ek/1000),'keV计算结果.mat'],'EM1','EM2','EM3','EM4','EM5');
save([work_path,'/',num2str(Ek/1000),'keV电子落点.mat'],'EMP');