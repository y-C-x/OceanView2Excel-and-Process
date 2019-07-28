% 2019/7/15
% Chengxin Yu

clc
clear

addpath('lib')
addpath('processFX')
addpath('lowpowerFX')

mkdir rawFile % original data goes here

welcomeMsg = 'Welcome to the OceanView 2 Excel and Process! (ver.9)';

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
LP = 0;

% % Grap data from Ocean View and write to the target excel

currentSet = [0,40,45,50,55,60,70,80,90,100,120,140,160,...
    180,200,220,240,260,280,285];

power = [16,23,29.2,36,42 ...
    55,69,82,95,123,152,181,212,243,274,304,337,370,378];

% data for low power

currentTitle = cell(8,1);
currentTitle{1,1} = '0 mA';
currentTitle{2,1} = '40 mA_60';
currentTitle{3,1} = '40 mA_70';
currentTitle{4,1} = '40 mA_80';
currentTitle{5,1} = '40 mA_90';
currentTitle{6,1} = '40 mA_100';
currentTitle{7,1} = '40 mA_140';
currentTitle{8,1} = '40 mA';

LPower = [2.2,4.5,6,8,10,11.5,17];
% currentSet = [0,40,45]; % only for test purpose

% power = [16,23];

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

while 1
    LPorN = input('Low Power(1/0)?','s');
    if ~(strcmp(LPorN,''))
        if strcmp(LPorN,'Q')
            disp(exitMsg);
            return;
        end
        if strcmp(LPorN,'1')
            LP = 1;
            break;
        elseif strcmp(LPorN,'0')
            LP = 0;
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
    
    if (LP == 1)
        R_W_function_LP(filenamePath,currentTitle);
    else
        R_W_function(filenamePath,currentSet);
    end
    
    % calculate the correct_int and write to the p_file
    lineBreak;
    pl_correct_int(filenamePath);
    
    % formate the calculation sheet
    lineBreak;
    
    if (LP == 1)
        calculation_table_LP(filenamePath,currentTitle);
    else
        calculation_table(filenamePath,currentSet);
    end
    
    
    lineBreak;
    disp('Done for collecting data.')
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    lineBreak;
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


if (LP ==1)
    
   % call LP read function 
    
    
    
end


% now create a copy of raw file for process


if (P == 1)
    
    contiProcess = 1;
    
    mkdir processFile
    
    while contiProcess
        
        if ~R
            filename = get_filename_P;
            if strcmp(filename,'Q')
                return
            end
            
            filenamePath = sprintf('%s%s','rawFile\',filename);
        end
        
        p_filename = extractBefore(filename,'.xlsx');
        p_filename = sprintf('%s_Processing.xlsx',p_filename);
        
        copyfile(filenamePath,p_filename);
        
        movefile (p_filename, 'processFile')
        
        p_filenamePath = sprintf('%s%s','processFile\',p_filename);
        
        %     % calculate the correct_int and write to the p_file
        %     lineBreak;
        %     pl_correct_int(p_filenamePath);
        %
        %     % formate the calculation sheet
        %     lineBreak;
        %     calculation_table(p_filenamePath,currentSet)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%% DATA PROCESS PART %%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        lineBreak;
        
        if (LP == 1)
            process_fx2(p_filenamePath,LPower,LP);
        else
            process_fx2(p_filenamePath,power,LP);
        end
        
        lineBreak;
        
        R = 0;
        
        exit = input('Continue processing(Y/N)? ','s');
        
        if strcmp(exit,'Y') || strcmp(exit,'y')
            lineBreak;
            lineBreak;
            
            while 1
                LPorN = input('Low Power(1/0)?','s');
                if ~(strcmp(LPorN,''))
                    if strcmp(LPorN,'Q')
                        disp(exitMsg);
                        return;
                    end
                    if strcmp(LPorN,'1')
                        LP = 1;
                        break;
                    elseif strcmp(LPorN,'0')
                        LP = 0;
                        break;
                    end
                end
            end
            
            continue;
        elseif strcmp(exit,'N') || strcmp(exit,'n')
            contiProcess = 0;
        else
            disp('Wrong cmd, exit instead');
            return;
        end
        
    end
end

lineBreak;
disp('MISSION COMPLETED');
% all set








