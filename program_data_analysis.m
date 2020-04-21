data_path = 'C:\Storage\data\einm\DATA_20200401';
%for E = [50 75 100 125 150 300 500 700 900 1001]
E = 1001;
    disp(['working on ',num2str(E),'keV...']);
    tic
    load([data_path,'/',num2str(E),'keV������.mat']);
    load([data_path,'/',num2str(E),'keV�������.mat']);
    loop_number = size(EM1,1);
    Ek = 1000*E;
    v= Cal_V(Ek);
    lx = 142; % 0~141��ÿ1mmһ����
    ly = 142; % 0~141��ÿ1mmһ����
    temp = [];
    for k = 1:loop_number
        
        if EM1(k) == 1
            [mx,my,mz,mphi,msita] = floopsettings_special(k,lx,ly);
        %*****�����˶�******
            P0 = [mx/1000,my/1000,mz/1000];
            V0 = [v*cos(-(msita/180+90/180)*pi)*sin((mphi/180)*pi), ...
                v*cos(-(msita/180+90/180)*pi)*cos((mphi/180)*pi), ...
                v*sin(-(msita/180+90/180)*pi)];
            temp = [temp;[P0 V0 EMP(k,:) -0.3305]];
        end
        save([data_path,'/',num2str(E),'keV���е������.mat'],'temp');
        
    end
    disp([num2str(E),'keV done!']);
    toc
%end