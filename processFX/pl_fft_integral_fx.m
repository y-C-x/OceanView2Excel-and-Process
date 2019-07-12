
function pl_fft_integral_fx(filename,wavRange)

    disp('start calculating fft integral');

    [~,sheets]=xlsfinfo(filename);

    endPos = extractAfter(wavRange,':a');
    endPos2 = num2str(str2double(endPos) + 1);
    XRange = strrep(wavRange,endPos,endPos2);
    
    dXRange = strrep(wavRange,'a','e');
    dYRange = strrep(wavRange,'a','d');
    
    startPos = extractBefore(wavRange,':');
    startPos = extractAfter(startPos,'a');
    startPos2 = num2str(str2double(startPos) + 1);
    dSRange = strrep(wavRange,startPos,startPos2);
    dSRange = strrep(dSRange,'a','f');
    
    str = cell(1);
    str{1} = 'sum_ftt';
    
    for h=3:length(sheets)
        name = sheets{h};
%         sheetnames = readtable(filename,'sheet',name) ;

%         cleanColumn = cell(1045,2);
%         xlswrite(filename,cleanColumn,name,'e1:f1045');
       
%         X=xlsread(filename,name,'a408:a564');
        X=xlsread(filename,name,XRange);

        for i = 1 : length(X) - 1
            dX(i)= X(i+1) - X(i);
        end


%         xlswrite(filename,dX,name, 'e408:e563');
        xlswrite(filename,dX,name,dXRange);
        
%         dY = xlsread(filename,name,'d408:d563');
        dY = xlsread(filename,name,dYRange);

        for i = 2:length(dY)
            mean(i-1) = (dY(i) + dY(i-1))/2;
            dS(i-1) = mean(i-1) * dX(i);
        end

        
%         xlswrite(filename,dS',name,'f409:f563')
        xlswrite(filename,dS',name,dSRange);

        S = sum(dS);

        xlswrite(filename, str(1), name, 'J1');
        xlswrite(filename, S, name, 'J2');
    end
    
    disp('Done')
end
