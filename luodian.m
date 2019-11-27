
fid=fopen('jizhong.txt','a');
fclose(fid);
parfor k = 1:13484016
     fid=fopen('jizhong.txt','w');
     
    W = abs(luodian(k,:));
    if 0.016 >=W(1) && 0.016 >=W(2)
        
         fprintf(fid,[num2str(W),'\n']);
    else
       
    end
    
    fclose(fid);
end