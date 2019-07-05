% 2019/7/3
% Chengxin Yu

clc
clear

addpath('lib')
addpath('processFX')

mkdir rawFile % original data goes here

welcomeMsg = 'Welcome to the OceanView 2 Excel and Process! (ver.8)';

intro = 'Type Q to exit.';


intro_1 = 'Your raw xlsx will be saved to rawFile directory.';
intro_2 = 'Processed xlsx file will be saved in processFile.';

exitMsg = 'Program terminated by the user.';

disp(welcomeMsg);
disp(intro);
lineBreak;
disp(intro_1);
disp(intro_2);

lineBreak

%%%%%%%%%%%%%%%%%%%%%%%
% general data area
R = 0;
P = 0;

% % Grap data from Ocean View and write to the target excel

%     currentSet = [0,40,45,50,55,60,70,80,90,100,120,140,160,...
%         180,200,220,240,260,280,285];

currentSet = [0,40,45]; % only for test purpose
%%%%%%%%%%%%%%%%%%%%%%%

while 1
    RorP = input('Record or Process(R/P)? ','s');
        if ~(strcmp(RorP,''))
            if strcmp(RorP,'Q')
                disp(exitMsg);
                return;
            end
            if strcmp(RorP,'R')
                R = 1;
                break;
            elseif strcmp(RorP,'P')
                P = 1;
                break;
            end
        end
end

%%%%%%% Record Mode %%%%%%%%%%
% read in filename
lineBreak;

if (R == 1)
    filename = get_filename_R;

    if strcmp(filename,'Q')
        return
    end

    filenamePath = sprintf('%s%s','rawFile\',filename);

    % R_W_function(filenamePath,currentSet);
    
    Pnow = input('process data now(Y/N)? ','s');
    
    if strcmp(Pnow,'Y')
        P = 1;
    elseif strcmp(Pnow,'N')
        lineBreak;
        disp('Done recording data, not processed yet');
        return;
    else 
        lineBreak;
        disp('Wrong cmd, exit anyway...');
        return;
    end
    
end


% now create a copy of raw file for process


if (P == 1)
    
    if ~R
        filename = get_filename_P;
        if strcmp(filename,'Q')
            return
        end

        filenamePath = sprintf('%s%s','rawFile\',filename);
    end
    
    mkdir processFile

    p_filename = extractBefore(filename,'.xlsx');
    p_filename = sprintf('%s_Processing.xlsx',p_filename);

    copyfile(filenamePath,p_filename);

    movefile (p_filename, 'processFile')

    p_filenamePath = sprintf('%s%s','processFile\',p_filename);


    % calculate the correct_int and write to the p_file
    lineBreak;
    pl_correct_int(p_filenamePath);

    % formate the calculation sheet
    lineBreak;
    calculation_table(p_filenamePath,currentSet)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    lineBreak;
    disp('Done for collecting data.')

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% DATA PROCESS PART %%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    lineBreak;
    process_fx(p_filenamePath);

end
% all set








