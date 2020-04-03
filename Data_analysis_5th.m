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

    To_count = EM4.*(1:Total)';
    To_count(all(To_count == 0,2)) = [];

    Ek = 1000*E;
    v= Cal_V(Ek);
    loop_number = size(To_count,1);
    W = zeros(loop_number,2);

    for k = 1:loop_number
        [mx,my,mz,mphi,msita] = floopsettings(To_count(k),lx,ly);
        P0 = [mx/1000,my/1000,mz/1000];
        V0 = [v*cos(-(msita/180+90/180)*pi)*sin((mphi/180)*pi), ...
            v*cos(-(msita/180+90/180)*pi)*cos((mphi/180)*pi), ...
            v*sin(-(msita/180+90/180)*pi)];
        [I0,pic] = if_without_megnet_field(P0,V0);%û�дų���ʱ��
        W(k,:) = pic;
    end

    figure
    scatter(W(:,1),W(:,2));
end


