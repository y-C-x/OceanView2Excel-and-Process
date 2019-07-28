function calculation_table(filename,currentTitle)
   
    title = cell(1,11);
    title{1,1} = 'Current (mA)';
    title{1,2} = 'Power (mW)';
    title{1,3} = 'Beam diameter (um)';
    title{1,4} = 'Power density (W/cm^2)';
    title{1,5} = 'Peak int';
    title{1,6} = 'Eff using peak';
    title{1,7} = 'peak wl';
    title{1,8} = 'peak int';
    title{1,9} = 'non-fft eff';
    title{1,10} = 'fft intg int';
    title{1,11} = 'eff using intg int';
    
    xlswrite(filename,title,'Calculation')
    
%     setNum = length(currentSet);
    
%     beamDiameter = input('Please give beam diameter(um): ','s');
    
%     for i = 1 : setNum-1
%         currentCell = sprintf('a%d',i+1);
% %         beamCell = sprintf('c%d',i+1);
%         xlswrite(filename,currentSet{1,i+1},'Calculation',currentCell);
% %         xlswrite(filename,beamDiameter,'Calculation',beamCell);
%     end
%     

    currentSet = cell(length(currentTitle),1);
    for i = 2 : length(currentTitle)
        currentSet{i-1,1} = strrep(currentTitle{i,1},' mA','');
    end

    xlswrite(filename,currentSet,'Calculation','a2');
    
    
    disp('Calculation sheet initialized')
end


								
