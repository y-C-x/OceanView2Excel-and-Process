function process_fx(filename,power)
    
    exitMsg = 'Program terminated by the user.';
%     filename = 'data.xlsx';
    intro = 'Data Process Starts';

    disp(intro)

    lineBreak;
    % wavRange = 'a400:a580';

    wavRange = input('give the wavLeng range to process (a..:a..): ','s');

    if strcmp(wavRange, 'Q')
        disp(exitMsg)
        return;
    end

    lineBreak;
    % fft calculation for all sheet
    wavRange = pl_fft_all_fx_ch(filename,wavRange);

    lineBreak;
    % fft integral for all sheet
    pl_fft_integral_fx(filename,wavRange);

    lineBreak;
    % find the peak wavelength
    pl_peak_wl_fx(filename,wavRange);

    lineBreak;
    % fill out the second table
    calculation_table2(filename,power);

    lineBreak;
    disp('Data process finish!')
    
    doneName = extractBefore(filename,'_Processing.xlsx');
    doneName = sprintf('%s_Processed.xlsx',doneName);
    
    movefile (filename,doneName);
end