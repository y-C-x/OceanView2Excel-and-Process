% this function will read in data copyed from Ocean View, and then
% write into a xlsx file specified by the user.

function R_W_function(filename,currentSet)
    
    exitMsg = 'Program terminated by the user.';
    
    warning('off','all') % surpress warning

%     currentSet = [0,40,45,50,55,60,70,80,90,100,120,140,160,...
%         180,200,220,240,260,280,285];

%     currentSet = [0,40,45]; % only for test purpose
    
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
    avgTime = input('Please give the avg time: ','s');
    
    if ~strcmp(avgTime,'Q')
        str{1} = avgTime;
        xlswrite(filename,str(1),'0 mA','F2');
        str{1} = 'avgTime';
        xlswrite(filename,str(1),'0 mA','E2');
    end
    

    for index = 1 : length(currentSet)
        fprintf('Waiting for data under current %d mA\n', currentSet(index));
        instruc = input('Hit return to confirm copy...','s');
        if strcmp(instruc,'Q')
            disp(exitMsg);
            return;
        end
        disp('copying data to excel.....')
        Ocean_Raw = paste;
        %     writecell(Ocean_Raw,filename,'Sheet',string([current{index},'mA']))
        xlswrite(filename,Ocean_Raw,sprintf('%d mA', currentSet(index)))
        disp('copy done!')
    end
    disp('All current sets are measured!')
    
    workbooksHandler(filename);
end
