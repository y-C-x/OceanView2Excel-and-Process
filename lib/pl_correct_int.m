% clc
% clear

% exitMsg = 'Program terminated by the user.';
% 
% while 1
%     filename = input('Please type in the xlsx file name to process: ','s')
%     if ~(strcmp(filename,''))
%         if strcmp(filename,'Q')
%             disp(exitMsg);
%             return;
%         end
%         break;
%     end
% end

% table(:,1) = xlsread('data.xlsx','0 mA','b408:b563');
% table(:,2) = xlsread('data.xlsx','40 mA','b408:b563')
% correctedInt(:,1) = table(:,2) - table(:,1);


function pl_correct_int(filename)
    
    disp('calculating correct_int...');
    warning('off','all') % surpress warning

    table(:,1) = xlsread(filename,'0 mA','b2:b1045');

    [~,sheetnames] = xlsfinfo(filename);

%     name = sheetnames{2};

    % this reads everything in a given sheet.
    % sheetnames = readtable('data.xlsx','sheet',name)


    str = cell(1);
    str{1} = 'correct int';

    for index = 3 : length(sheetnames)
        xlswrite(filename,str(1), sheetnames{index}, 'c1')
        table(:,index-1) = xlsread(filename,sheetnames{index},'b2:b1045');
        correctedInt(:,index-2) = table(:,index-1) - table(:,1);
        xlswrite(filename,correctedInt(:,index-2), sheetnames{index},'c2:c1045')
    end
    
    disp('correct_int written')
end



