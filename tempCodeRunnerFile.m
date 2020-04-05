    Special_phi_1 = [50 50 50 100 100 90 120 125 120];%phi角下限
    Special_phi_2 = [190 150 150 210 180 150 200 180 150];
    %range|165,180|160,180|160,180|160,180|158,180|150,180|150,180|150,180|150,180
    Special_sita_1 = [165 160 160 160 158 150 150 150 150] - 180;%sita角下限
    Special_sita_2 = [179 179 179 179 179 179 179 179 179] - 180;

    lx = 142; % 0~141，每1mm一个点
    ly = 142; % 0~140，每1mm一个点
    %phi角每个取2°
    lphi = (Special_phi_2 - Special_phi_1)./2 + 1;
    %sita角每个取1°
    lsita = (Special_sita_2 - Special_sita_1) + 1;
    Total = lx*ly*sum(((Special_phi_2 - Special_phi_1)./2 + 1).*((Special_sita_2 - Special_sita_1) + 1));%总数