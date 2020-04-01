%% step1

path  = 'C:\Storage\data\einm\DATA_20200331';

lx = 142; % 0~141，每1mm一个点
ly = 142; % 0~141，每1mm一个点
Total = lx*ly;%总数
%% 循环计算
%%

for E = [50 75 100 125 150 300 500 700 900 1000]
    
    %% 读取数据
    
    load([path,'/',num2str(E),'keV计算结果.mat']);
    load([path,'/',num2str(E),'keV电子落点.mat']);
    %电子落点图
    %scatter(EMP(:,1),EMP(:,2),'.');
    %figure
    count = zeros(1,9);
    for k = 1:9

        k1 = (k - 1)*Total/9 + 1;
        k2 = k*Total/9;
        count(k) = sum(EM1(k1:k2));

    end
    disp(num2str(count));
    %Data = zeros(Total,5);
    %parfor k = 1:Total
        %if EM1(k) == 1
            %Data(k,:) = floopsettings(k,lx,ly);
        %end
    %end
    %scatter(Data(:,1),Data(:,2),'.');
    %figure
    
end