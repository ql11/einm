%*************************循环主程序********************************
parpool('local',32); %开启并行池
parfor E = 1:32
    disp(num2str(E));
end
start_time = datestr(now,'日期yyyy-mm-dd 时间HH:MM:SS');
disp(['程序开始时间：【',start_time,'】']);
this_path = '/public1/home/sc40009/jobs/140x140';
addpath(this_path);
%% 第一步读取磁场数据*********
disp('程序开始，读取磁场数据中……');
tic
load('/public1/home/sc40009/jobs/Enim_Total/data_V1031.mat');
disp('data_V1031.mat读取完毕，开始设定参数……');
toc

%% 第二步设定参数初始值*********
E = 1000;
    Ek = 1000*E; %todo
    v= Cal_V(Ek);



    disp('参数设定完毕，开始循环计算……');

    Special_z =[40.1 37.8 32.9 37.8	35.5 30.6 32.9 30.6	25.7];
    %range|-180,-50 170,180|-125,-75 160,180|-125,-75|-180,-150|-180,-100|-170,-100|-140,-100|-180,-150 160,180|-180,-125|-150,-120
    Special_phi_1 = [50 50 50 100 100 90 120 125 120];%phi角下限
    Special_phi_2 = [190 150 150 210 180 150 200 180 150];
    %range|165,180|160,180|160,180|160,180|158,180|150,180|150,180|150,180|150,180
    Special_sita_1 = [165 160 160 160 158 150 150 150 150] - 180;%sita角下限
    Special_sita_2 = [179 179 179 179 179 179 179 179 179] - 180;

    lx = (140 - 0)/2 + 1; % 0~140，每2mm一个点
    ly = (140 - 0)/2 + 1; % 0~140，每2mm一个点
    %phi角每个取5°
    lphi = (Special_phi_2 - Special_phi_1)./5 + 1;
    %sita角每个取1°
    lsita = (Special_sita_2 - Special_sita_1) + 1;
    Total = lx*ly*sum(lphi.*lsita);%总数
    EM1 = zeros(Total,1);% 击中目标区域
    EM2 = zeros(Total,1);%无磁场时会打到目标区域的电子
    EM3 = zeros(Total,1);%无磁场时会打到目标区域，加上磁场之后也会打到目标区域的电子
    EM4 = zeros(Total,1);%无磁场时不会打到目标区域，而加上磁场之后会打到目标区域的电子
    EM5 = zeros(Total,1);%无磁场时会打到目标区域，加上磁场之后不会打到目标区域的电子
    EMP = zeros(Total,2);%显示落点
    EM_record = zeros(Total,13);% 记录序号和初始位置速度、终末位置速度
    parfor k = 1:Total
        [mx,my,mz,mphi,msita] = floopsettings((k - 1),lx,ly,lphi,lsita,Special_z,Special_phi_1,Special_sita_1);
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
                EM_record(k,:) = [k,P0,V0,P,V];
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
    fid = fopen([this_path,'/',num2str(Ek/1000),'keV结果概览.txt'],'w');

    disp(['总计算的电子数【',num2str(Total),'】','击中目标区域的电子数【',num2str(sum(EM1)),'】',' 程序开始时间：【',start_time,'】 程序结束时间【',end_time,'】']);
    fprintf(fid,['总计算的电子数【',num2str(Total),'】','击中目标区域的电子数【',num2str(sum(EM1)),'】',' 程序开始时间：【',start_time,'】 程序结束时间【',end_time,'】']);

    disp(['无磁场时会打到目标区域的电子数【',num2str(sum(EM2)),'】','无磁场时会打到目标区域，加上磁场之后也会打到目标区域的电子数【',num2str(sum(EM3)),'】','无磁场时不会打到目标区域，而加上磁场之后会打到目标区域的电子数【',num2str(sum(EM4)),'】','无磁场时会打到目标区域，加上磁场之后不会打到目标区域的电子数【',num2str(sum(EM5)),'】',]);
    fprintf(fid,['无磁场时会打到目标区域的电子数【',num2str(sum(EM2)),'】','无磁场时会打到目标区域，加上磁场之后也会打到目标区域的电子数【',num2str(sum(EM3)),'】','无磁场时不会打到目标区域，而加上磁场之后会打到目标区域的电子数【',num2str(sum(EM4)),'】','无磁场时会打到目标区域，加上磁场之后不会打到目标区域的电子数【',num2str(sum(EM5)),'】',]);
    fclose(fid);

    save([this_path,'/',num2str(Ek/1000),'keV计算结果.mat'],'EM1','EM2','EM3','EM4','EM5','EM_record');
    save([this_path,'/',num2str(Ek/1000),'keV电子落点.mat'],'EMP');

