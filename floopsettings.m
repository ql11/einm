function [mx,my,mz,mphi,msita] = floopsettings(k,lx,ly);
    %将嵌套循环化为统一循环
    % k = 1~Total 
    Special_z =[40.1 37.8 32.9 37.8	35.5 30.6 32.9 30.6	25.7];
    Special_phi = [135	111.3 103.6 158.7 135.0 121.8 166.4 148.2 135];
    Special_sita = [3.00 5.85 9.05 5.85	7.72 10.36 9.05	10.36 12.47];
    my = mod(k-1,lx);
    mx = ((k - 1) - my)/ly;
    n = floor(9*k/lx/ly);
    mz = Special_z(n);
    mphi = Special_phi(n);
    msita = Special_sita(n);
end
