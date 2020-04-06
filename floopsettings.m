function [mx,my,mz,mphi,msita] = floopsettings(k,lx,ly,lphi,lsita,Special_z,Special_phi_1,Special_sita_1)
    %将嵌套循环化为统一循环；排列次序以第三象限的次序为基准
    %将phi角和sita角放在更高级的位置，先算x和y
    num_x = lx/3;
    num_y = ly/3;
    num_1 = k;
    num_2 = lphi.*lsita.*((num_x)*(num_y)); 
    %判断位置1~9
    n = 0;
    if k == 0
        n = 1;
        num_1 = num_1 - num_2(n);
    else
        while num_1 > 0
            n = n + 1;
            num_1 = num_1 - num_2(n);
        end
    end
    %通过区域赋值mz
    mz = Special_z(n);

    %计算
    num_1 = num_1 + num_2(n);
    n_y = mod((n - 1),3);n_x = floor((n - 1)/3);% (0,0)~(2,2)一共9个区域
    msita_0 = mod(num_1,lsita(n));
    mphi_0 = floor(mod(num_1,(lphi(n)*lsita(n)))/lsita(n));
    m_y_0 = floor(mod(num_1,(lphi(n)*lsita(n)*num_y))/(lphi(n)*lsita(n)));
    m_x_0 = floor(num_1/(lphi(n)*lsita(n)*num_y));

    msita = msita_0 + Special_sita_1(n);
    mphi = 5*mphi_0 + Special_phi_1(n);
    mx = 2*(m_x_0 + n_x*24);
    my = 2*(m_y_0 + n_y*24);

end
