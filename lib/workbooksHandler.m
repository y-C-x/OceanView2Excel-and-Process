function workbooksHandler(filename)

    currentFolder = pwd;

    currentPath = sprintf('%s\\%s',pwd,filename);

    try
        Excel=actxGetRunningServer('Excel.Application');
    catch
        Excel = actxserver('Excel.Application');
    end;

    Workbooks = Excel.Workbooks;

    if exist(currentPath,'file');
        Workbook = invoke(Workbooks,'Open',currentPath);
    else
        Workbook = invoke(Workbooks, 'Add');
        Workbook.SaveAs(currentPath);
    end
    
    Sheets = Excel.ActiveWorkBook.Sheets;
    Count = Excel.ActiveWorkbook.Sheets.Count;
    
    Sheets.Item(1).Name = 'Calculation';
    
    disp('Modified Successfully');

    Excel.ActiveWorkbook.Save; 
    Excel.ActiveWorkbook.Close;
%     Excel.Quit;
%     Excel.delete;
end