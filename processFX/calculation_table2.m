function calculation_table2(filename)

    disp('start filling calculation table');
%     filename = 'data.xlsx';
 
    calSheet = 'Calculation';
    disp('writing data to calculation table');
    
    disp('Assume input power(mW) is fixed here for specific current(mA)')
    
    power = [16,23,29.2,36,42 ...
        55,69,82,95,123,152,181,212,243,274,304,337,370,378];

%     power = [16,23];
    
    [~,sheetnames]=xlsfinfo(filename);
    
    N = length(sheetnames) -1 ;
    
    cleanSheet = cell(N-1,10);
    cleanRange = sprintf('b2:k%d',N);
    xlswrite(filename,cleanSheet,calSheet,cleanRange)
    
    %
    powerRange = sprintf('b2:b%d',N);
    xlswrite(filename,power',calSheet,powerRange)
    
    %
    beamDiameter = input('Please enter beam diameter(um): ');
    
    beamDRange = sprintf('c2:c%d',N);
    xlswrite(filename,beamDiameter,calSheet,beamDRange);
    
    %
    for i = 1: (N-1)
        powerPerA(i) = (power(i).*10^-3)/(pi*((beamDiameter*10^-4)/2).^2);
    end
    
    powerPerARange = sprintf('d2:d%d',N);
    xlswrite(filename,powerPerA',calSheet,powerPerARange);
    

    
    for h=3:length(sheetnames)
        name = sheetnames{h};
        
        % Peak Int
        PeakInt = xlsread(filename,name,'L2');
        xlswrite(filename,PeakInt,calSheet,sprintf('e%d',h-1));
        
        % Eff using peak
    
        effPeak = PeakInt./power(h-2)/(2.423*7);
        xlswrite(filename,effPeak,calSheet,sprintf('f%d',h-1));
        
        % peak wave length
        
        peakWavLen = xlsread(filename,name,'M2');
        xlswrite(filename,peakWavLen,calSheet,sprintf('g%d',h-1));
        
        % peak int
        
        peakint = xlsread(filename,name,'I2');
        xlswrite(filename,peakint,calSheet,sprintf('h%d',h-1));
        
        % non-fft eff
        non_fft_eff = peakint./power(h-2)/(2.523*7); %2.423 or 2.523
        xlswrite(filename,non_fft_eff,calSheet,sprintf('i%d',h-1));
        
        % fft intg int
        fft_intgint = xlsread(filename,name,'J2');
        xlswrite(filename,fft_intgint,calSheet,sprintf('j%d',h-1));
        
        % fft eff
        fft_eff = fft_intgint./power(h-2)/(133.397*7);
        xlswrite(filename,fft_eff,calSheet,sprintf('k%d',h-1));
        
    end
    
    disp('Done');
end