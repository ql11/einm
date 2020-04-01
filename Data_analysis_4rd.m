%% step1

path  = 'C:\Storage\data\einm\DATA_20200401';

lx = 142; % 0~141��ÿ1mmһ����
ly = 142; % 0~141��ÿ1mmһ����
Total = lx*ly;%����
%% ѭ������
%%
E_count = zeros(9,9); %ÿһ�ж�Ӧ�ٶ�
E0 = [50 75 100 125 150 300 500 700 1001];
for i = 1:9
    E = E0(i);
    %% ��ȡ����
    
    load([path,'/',num2str(E),'keV������.mat']);
    load([path,'/',num2str(E),'keV�������.mat']);
    %�������ͼ
    %figure
    %scatter(EMP(:,1),EMP(:,2),'.');
    Data = zeros(Total,5);
    for k = 1:Total
        if EM1(k) == 1
            [Data(k,1),Data(k,2),~,~,~] = floopsettings(k,lx,ly);

            my = mod(k-1,lx);
            mx = ((k - 1) - my)/ly;  
            n47 = (lx - 1)/3;
            if mx <= n47
                if my <= n47
                    n = 1;
                elseif my <= 2*n47
                    n = 2;
                else
                    n = 3;
                end
            elseif mx <= 2*n47
                if my <= n47
                    n = 4;
                elseif my <= 2*n47
                    n = 5;
                else
                    n = 6;
                end
            else
                if my <= n47
                    n = 7;
                elseif my <= 2*n47
                    n = 8;
                else
                    n = 9;
                end
            end

            E_count(i,n) = E_count(i,n) + 1;
        end
    end
    figure
    scatter(Data(:,1),Data(:,2),'.');
    disp([num2str(E),'���и���:',num2str(E_count(i,:))]);
    
end