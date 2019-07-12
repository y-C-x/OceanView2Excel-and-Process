function pl_peak_wl_fx(filename,wavRange)

    disp('start calculating peak wavelength')
    [~,sheets]=xlsfinfo(filename);
    
    intenRange = strrep(wavRange,'a','d');
    
    str = cell(1);
    str{1} = 'peak wavLen';

    for h=3:length(sheets)
        name = sheets{h};
%         sheetnames = readtable(filename,'sheet',name) ;

        X=xlsread(filename,name,wavRange);
        
        
        Y=xlsread(filename,name,intenRange);

        YY=transpose(Y); %intensity

        p_int=max(YY);

        for i=1:length(YY)
            if YY(i) == p_int
                n=i;
            end
        end

        XX = transpose(X);

        p_wl = XX(n); %peak wl
       
        xlswrite(filename,str(1),name,'m1');
        xlswrite(filename,p_wl,name,'m2');

    end
    disp('Done');
end