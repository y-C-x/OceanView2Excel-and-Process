function fftN = pl_fft_fx_ch(filename,wavRange)

    intCRange = strrep(wavRange,'a','c');

    % startPos = extractBefore(wavRange,':');
    % startPos = extractAfter(startPos,'a');
    %
    % endPos = extractAfter(wavRange,':a');

    X=xlsread(filename,'40 mA',wavRange);
    Y=xlsread(filename,'40 mA',intCRange);


    % figure(1)
    % plot(X,Y)
    % xlim([520 640]);
    % %
    % %
    Z0 = fft(Y);

    Z = Z0;
    %
    N = length(X);
    i = (1:N);

    fig = figure('Name','fft - plot');
    WinOnTop(fig); % keep fig windows on top
    subplot(2,2,1)
    plot(abs(Z));
    titleName = sprintf('Original from %d - %d',1,N);
    title(titleName)

    % % noise handling

    startN = 5;
    endN = N - 4;

    Z(i>=startN & i <= endN) = 0;

    subplot(2,2,3)
    plot(abs(Z));
    titleName = sprintf('Zero from %d - %d',5,N-4);
    title(titleName);

    YY = ifft(Z);

    subplot(2,2,[2 4])
    plot(X,abs(YY),'b',X,Y,'r');

    confirm = 0;

    while ~confirm
        cmd = input('Confirm this fft (Y/N)? ','s');
        if strcmp(cmd,'Y') || strcmp(cmd,'y')
            confirm = 1;
            break;
        elseif strcmp(cmd,'N') || strcmp(cmd,'n')
            startN = input('give new start N: ');
            endN = input('give new end N: ');
            Z = Z0;
            Z(i>=startN & i <= endN) = 0;
            subplot(2,2,3)
            plot(abs(Z));
            titleName = sprintf('Zero from %d - %d',startN,endN);
            title(titleName);
            YY = ifft(Z);
            subplot(2,2,[2 4])
            plot(X,abs(YY),'b',X,Y,'r');
        else
            disp('Give correct ans plz');
        end
    end

    if confirm
        fftN = [startN, endN];
        %     xlswrite(filename,abs(YY),'40 mA',fftRange);
        %     disp('sucessful write fft to excel');
        close all
    end
end