function filename = get_filename

    exitMsg = 'Program terminated by the user.';
    while 1
        filename = input(['Please type in the .xlsx file'...
            'name(include .xlsx) to process: '],'s');
        if ~(strcmp(filename,''))
            if strcmp(filename,'Q')
                disp(exitMsg);
                return;
            end
            break;
        end
    end
end