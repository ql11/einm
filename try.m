start_time = datestr(now,' 日期yyyy-mm-dd 时间HH:MM:SS');
disp([' 程序开始时间：【',start_time,'】']);

parfor k = 1:13484016
     fid=fopen('jizhong.txt','a');
     
    W = luodain(k,:)
    if 0.016 >= abs(W(1)) && 0.016 >=abs(W(2)) 
     fprintf(fid,[num2str(W),'\n']);
    end
    
    
end