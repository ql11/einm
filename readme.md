# x50y20
## 取点特性
lx = 50; % 0~49，每1mm一个点
ly = 20; % 120~139，每1mm一个点
lphi = 46; % 0°~180°，每4°一个点
lsita = 11; % -20°~20°，每4°一个点
## 点位序号与取点对应
mx = floor(k/(ly*lphi*lsita));
my = 120 + floor(mod(k,(ly*lphi*lsita))/(lphi*lsita));
mphi = 4*floor(mod(mod(k,(ly*lphi*lsita)),(lphi*lsita))/lsita);
msita = 4*mod(mod(mod(k,(ly*lphi*lsita)),(lphi*lsita)),lsita) - 20;
## 取点特征转化方式
Data_0(:,3) = Data_0(:,3).*sign(Data_0(:,4));
Data_0(:,4) = 180 - abs(Data_0(:,4));