data_path = 'C:\Storage\data\einm\DATA_20200408';
for E = [50 75 100 150 300 500 700 900]
    load([data_path,'/',num2str(E),'keV������.mat']);
    load([data_path,'/',num2str(E),'keV�������.mat']);
    figure
    scatter(EMP(:,1),EMP(:,2),'.');
    set(gca,'XLim',[-2 2]);%X���������ʾ��Χ
    set(gca,'YLim',[-2 2]);%X���������ʾ��Χ
    M1 = EMP.*EM1;
    figure
    scatter(M1(:,1),M1(:,2),'.');
end