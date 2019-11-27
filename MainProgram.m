%********************************************循环主程序************************************************

start_time = datestr(now,' 日期yyyy-mm-dd 时间HH:MM:SS');
disp([' 程序开始时间：【',start_time,'】']);


%% 第一步读取磁场数据*********
disp('程序开始，读取磁场数据中……');
tic
load('/public1/home/sc40009/jobs/20191119_25keV/program/mark_1120.mat');
disp('读取完毕，开始设定参数……');
toc



%% 第二步设定参数初始值*********




disp('参数设定完毕，开始循环计算……');

fid=fopen('显示记录.txt','w');
fid_1 = fopen('数据记录_所有击中目标区域的电子.txt','w');
fid_2 = fopen('数据记录_无磁场时会打到目标区域的电子.txt','w');
fid_3 = fopen('数据记录_无磁场时会打到目标区域，加上磁场之后也会打到目标区域的电子.txt','w');
fid_4 = fopen('数据记录_无磁场时不会打到目标区域，而加上磁场之后会打到目标区域的电子.txt','w');
fid_5 = fopen('数据记录_无磁场时会打到目标区域，加上磁场之后不会打到目标区域的电子.txt','w');
fid_6 = fopen('全部电子落点.txt','w');

fclose(fid);
fclose(fid_1);fclose(fid_2);fclose(fid_3);fclose(fid_4);fclose(fid_5);fclose(fid_6);
%% 循环计算
lx = 166/2 + 1; % 每0.2mm一个点
ly = 166/2 + 1; % 每0.2mm一个点

lphi = 180/2 + 1; % 0°~180°，每2°一个点

lsita = 40/2 + 1; % -20°~20°，每2°一个点

Total = lx*ly*lphi*lsita;%总数


parfor k = 0:(Total - 1)
% for k = 0:(Total - 1)
    [~,v,OP,~,~] = settings(1);
    [mx,my,mphi,msita] = floopsettings(k,lx,ly,lphi,lsita);
    fid=fopen('显示记录.txt','a');
    fid_1 = fopen('数据记录_所有击中目标区域的电子.txt','a');
    fid_2 = fopen('数据记录_无磁场时会打到目标区域的电子.txt','a');
    fid_3 = fopen('数据记录_无磁场时会打到目标区域，加上磁场之后也会打到目标区域的电子.txt','a');
    fid_4 = fopen('数据记录_无磁场时不会打到目标区域，而加上磁场之后会打到目标区域的电子.txt','a');
    fid_5 = fopen('数据记录_无磁场时会打到目标区域，加上磁场之后不会打到目标区域的电子.txt','a');
    fid_6 = fopen('全部电子落点.txt','a');
    

    %*****计算运动******
    P0 = [mx/1000,-my/1000,OP(3)];
    V0 = [v*cos(-((msita/180)/180+90/180)*pi)*sin((mphi/180)*pi), ...
        v*cos(-((msita/180)/180+90/180)*pi)*cos((mphi/180)*pi), ...
        v*sin(-((msita/180)/180+90/180)*pi)];
    
    [P,V,~] = yun_dong(P0,V0,Fx,Fy,Fz);
    
    %*******做判断*********
    [I0,~] = if_without_megnet_field(P0,V0);%没有磁场的时候
    [I,W] = pan_duan_shi_fou_neng_she_dao_ban_zi_shang(P,V);%做判断
    
    %*******显示输出*********
    
    nowtime = datestr(now,' 日期yyyy-mm-dd 时间HH:MM:SS');
    
    if I
        disp([nowtime,' ',' 初始速度为 |',num2str(V0), '| 初始位置为 |',num2str(P0), '| ', ' ','穿出速度为 |',num2str(V), '| 穿出位置为 |',num2str(P),'|']);
        fprintf(fid,[nowtime,' ',' 初始速度为 |',num2str(V0), '| 初始位置为 |',num2str(P0), '| ', ' ','穿出速度为 |',num2str(V), '| 穿出位置为 |',num2str(P),'|\n']);
        fprintf(fid_1,[num2str(V0), ' ',num2str(P0), ' ',num2str(V), ' ',num2str(P), '\n']);
       %*******显示落点*********

        fprintf(fid_5,[num2str(W),'\n']);
    end
    
    %*******显示落点*********
    absW = abs(W);
    

    fprintf(fid_6,[num2str(W),'\n']);

    
    %*******典型数据记录*********
    if I0
        fprintf(fid_2,[num2str(V0), ' ',num2str(P0), ' ',num2str(V), ' ',num2str(P), '\n']);%无磁场时会打到目标区域的电子
    end
    
    if I0 && I
        fprintf(fid_3,[num2str(V0), ' ',num2str(P0), ' ',num2str(V), ' ',num2str(P), '\n']);%无磁场时会打到目标区域，加上磁场之后也会打到目标区域的电子
    end
    
    if (~I0) && I
        fprintf(fid_4,[num2str(V0), ' ',num2str(P0), ' ',num2str(V), ' ',num2str(P), '\n']);%无磁场时不会打到目标区域，而加上磁场之后会打到目标区域的电子
    end
    
    if I0 && (~I)
        fprintf(fid_5,[num2str(V0), ' ',num2str(P0), ' ',num2str(V), ' ',num2str(P), '\n']);%无磁场时会打到目标区域，加上磁场之后不会打到目标区域的电子
    end
    
    fclose(fid);
    fclose(fid_1);fclose(fid_2);fclose(fid_3);fclose(fid_4);fclose(fid_5);fclose(fid_6);
    
    if rem(10000*k,Total) == 0
       disp([num2str(100*k/Total),'%']) ;
    end

end

end_time = datestr(now,' 日期yyyy-mm-dd 时间HH:MM:SS');

%% 总结
fid=fopen('显示记录.txt','a');
disp(['总计算的电子数【', num2str(Total),'】',' 程序开始时间：【',start_time,'】 程序结束时间【',end_time,'】']);
fprintf(fid,['总计算的电子数【',num2str(Total),'】',' 程序开始时间：【',start_time,'】 程序结束时间【',end_time,'】','\n']);
fclose(fid);

