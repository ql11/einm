%********************************************循环主程序************************************************
%% 定义写入文件
start_time = datestr(now,' 日期yyyy-mm-dd 时间HH:MM:SS');
disp([' 程序开始时间：【',start_time,'】']);

fid=fopen('程序记录.txt','w');
fprintf(fid,['程序开始时间：【',start_time,'】','\n']);
fid_1 = fopen('【数据记录】所有击中目标区域的电子.txt','w');

fid_6 = fopen('【数据记录】全部电子落点【正负2.50m】.txt','w');
fid_7 = fopen('【数据记录】计算的电子个数.txt','w');

fclose(fid);
fclose(fid_1);fclose(fid_6);fclose(fid_7);

parpool('local')%开启并行运算池

%% 第一步读取磁场数据*********
disp('程序开始，读取磁场数据中……');
tic
load('/public1/home/sc40009/jobs/Ger20kev/121601.mat');


disp('0110_V.mat读取完毕，开始设定参数……');
toc

%% 第二步设定参数初始值*********

[~,v,~,~,~] = settings(1);
disp('参数设定完毕，开始循环计算……');

%% 循环计算
% 循环设定
angle = 180;

lx = 152;ly = 152;lphi = 181;lsita = 11;
Total = lx*ly*lphi*lsita;%总数

parfor k = 0:(Total - 1)
    [mx,my,mphi,msita] = floopsettings(k,lx,ly,lphi,lsita);
    P0 = [mx/1000,my/1000,0.01999];
    fid=fopen('程序记录.txt','a');
    fid_1 = fopen('【数据记录】所有击中目标区域的电子.txt','a');
    
    fid_6 = fopen('【数据记录】全部电子落点【正负2.50m】.txt','a');
    
    if original_position(P0)
        V0 = [v*cos(-((msita/angle)/180+90/180)*pi)*sin((mphi/angle)*pi), ...
            v*cos(-((msita/angle)/180+90/180)*pi)*cos((mphi/angle)*pi), ...
            v*sin(-((msita/angle)/180+90/180)*pi)];
        %******记数********
        fid_7 = fopen('【数据记录】计算的电子个数.txt','a');
        nowtime = datestr(now,' 日期yyyy-mm-dd 时间HH:MM:SS');
        fprintf(fid_7,[nowtime,' ',' |',num2str(V0), ' |',num2str(P0),'|\n']);
        fclose(fid_7);
        
        [P,V,~] = yun_dong(P0,V0,Fx,Fy,Fz);
        %*******做判断*********
        [I0,~] = if_without_megnet_field(P0,V0);%没有磁场的时候
        [I,W] = pan_duan_shi_fou_neng_she_dao_ban_zi_shang(P,V);%做判断
        %*******显示输出*********
        
        
        if I
            disp([nowtime,' ',' 初始速度为 |',num2str(V0), '| 初始位置为 |',num2str(P0), '| ', ' ','穿出速度为 |',num2str(V), '| 穿出位置为 |',num2str(P),'|']);
            fprintf(fid,[nowtime,' ',' 初始速度为 |',num2str(V0), '| 初始位置为 |',num2str(P0), '| ', ' ','穿出速度为 |',num2str(V), '| 穿出位置为 |',num2str(P),'|\n']);
            fprintf(fid_1,[' ',num2str(V0), ' ',num2str(P0), ' ',num2str(V), ' ',num2str(P), '\n']);
        end
        %*******显示落点*********
        absW = abs(W);
        
        if absW(1) < 2.50 && absW(2) < 2.50
            fprintf(fid_6,[num2str(W),'\n']);
        end

    end
    fclose(fid);
    fclose(fid_1);fclose(fid_6);
    
    
end
end_time = datestr(now,' 日期yyyy-mm-dd 时间HH:MM:SS');

%% 总结

disp([' 程序开始时间：【',start_time,'】 程序结束时间【',end_time,'】']);

fid=fopen('程序记录.txt','a');

fprintf(fid,[' 程序开始时间：【',start_time,'】 程序结束时间【',end_time,'】','\n']);

fclose(fid);

