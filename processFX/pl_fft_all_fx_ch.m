function wavR = pl_fft_all_fx_ch(filename,wavRange)

    disp('Calculating fft for all sheet...')
    
    [wavR,fftN] = pl_fft_fx_ch(filename,wavRange);
    
    wavRange = wavR;
    
    intCRange = strrep(wavRange,'a','c');
    fftRange = strrep(wavRange,'a','d');
    
    startN = fftN(1);
    endN = fftN(2);
    
    [~,sheets]=xlsfinfo(filename);
    
    str = cell(1,2);
    str{1,1} = 'p_int(max)';
    str{1,2} = 'nfft(max)';

    for h=3:length(sheets)
        name = sheets{h};
%         sheetnames = readtable(filename,'sheet',name);

        X=xlsread(filename,name,wavRange);
        Y=xlsread(filename,name,intCRange);
        
%         cleanColumn = cell(1045,1);
%         xlswrite(filename,cleanColumn,name,'d1:d1045');

        Z = fft(Y);
        
        N = length(X);
        i = (1:N);

        Z(i>=startN & i<=endN) = 0;

        YY = ifft(Z);
        
        xlswrite(filename,abs(YY),name,fftRange);

        p_int=max(abs(YY));
        xlswrite(filename,str(1,1),name,'l1');
        xlswrite(filename,p_int,name,'l2');

        p_int_nfft=max(Y);
        xlswrite(filename,str(1,2),name,'i1');
        xlswrite(filename,p_int_nfft,name,'i2');

    end
   
    disp('Done')
end