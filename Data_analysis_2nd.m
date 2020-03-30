%% step 1

clear
lx = 50; % 0~49，每1mm一个点
ly = 20; % 120~139，每1mm一个点
lphi = 46; % 0°~180°，每4°一个点
lsita = 11; % -20°~20°，每4°一个点
Total = lx*ly*lphi*lsita;%总数
phi_1 = -125;
Phi_2 = -75;
sita_1 = 170;
sita_2 = 175;
%% step 2
%%
scatter(EMP(:,1),EMP(:,2),'.');
%% step 3
%%
M1 = EMP.*EM1;
scatter(M1(:,1),M1(:,2),'.');
%% step 4
%%
Data = zeros(Total,4);
parfor k = 1:size(EM1,1)
    if EM1(k) == 1
        % k值换算成位置和角度
        mx = 4*floor(k/(ly*lphi*lsita));
        my = 4*floor(mod(k,(ly*lphi*lsita))/(lphi*lsita));
        mphi = 10*floor(mod(mod(k,(ly*lphi*lsita)),(lphi*lsita))/lsita);
        msita = 2*mod(mod(mod(k,(ly*lphi*lsita)),(lphi*lsita)),lsita) - 20;
    end
end
Data_0 = zeros(size(Data));

parfor k = 1:size(Data,1)
    if Data(k,4) ~= 0
        Data_0(k,:) = Data(k,:);
    end
end
Data_0(:,3) = Data_0(:,3).*sign(Data_0(:,4));
Data_0(:,4) = 180 - abs(Data_0(:,4));
Danger = zeros(size(Data_0,1),1);
parfor k = 1:size(Data_0,1)
    if Data_0(k,3) >= -125 && Data_0(k,3) <= -75 && Data_0(k,4) >= 170 && Data_0(k,4) <= 175
        Danger(k) = 1;
    end
end
M2 = EMP.*Danger;
scatter(M2(:,1),M2(:,2),'.');
sum(Danger)