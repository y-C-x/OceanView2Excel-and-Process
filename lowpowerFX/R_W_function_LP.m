% this function will read in data copyed from Ocean View, and then 
%           write into a xlsx file specified by the user.

function R_W_function(filename,currentSet)
    
    exitMsg = 'Program terminated by the user.';
    
    warning('off','all') % surpress warning
    
    disp('Starting reading from OceanView')
    
    str = cell(1);
%   Read integration time
    intTime = input('Please give the integration time(ms): ','s');
    
    if ~strcmp(intTime,'Q')
        str{1} = intTime;
        xlswrite(filename,str(1),'0 mA','F1');
        str{1} = 'integration time(ms)';
        xlswrite(filename,str(1),'0 mA','E1');
    end
    
%   Read avg time
    avgScan = input('Please give the avg Scan: ','s');
    
    if ~strcmp(avgScan,'Q')
        str{1} = avgScan;
        xlswrite(filename,str(1),'0 mA','F2');
        str{1} = 'avg Scan';
        xlswrite(filename,str(1),'0 mA','E2');
    end
    
    index = 1;
    while index <= length(currentSet)
        fprintf('Waiting for data under current %s\n', currentSet{index,1});
        instruc = input('Hit return to confirm copy...','s');
        
        if strcmp(instruc,'Q')
            disp(exitMsg);
            return;
        end
        
        if strcmp(instruc,'Rewrite')
            I = input('Type in the angle you want to rewrite: ');
            fprintf('Waiting for data under current 40 mA_%d\n', I);
            input('Hit return to confirm copy...','s');
            disp('copying data to excel.....')
            Ocean_Raw = paste;
            xlswrite(filename,Ocean_Raw,sprintf('40 mA_%d', I));
            disp('copy done!')
            index = index - 1;
        else
            disp('copying data to excel.....')
            Ocean_Raw = paste;
            %     writecell(Ocean_Raw,filename,'Sheet',string([current{index},'mA']))
            xlswrite(filename,Ocean_Raw,sprintf('%s', currentSet{index,1}))
            disp('copy done!')
        end
        
        index = index + 1;
    end
    disp('All current sets are measured!')
    
    workbooksHandler(filename);
end
