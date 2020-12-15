Function ExcelToCsv ($File) {
    $myDir = "C:\Powershell\"
    $excelFile = "$myDir\" + $File + ".xlsx"
    $Excel = New-Object -ComObject Excel.Application
    $wb = $Excel.Workbooks.Open($excelFile)
	
    foreach ($ws in $wb.Worksheets) {
        $ws.SaveAs("$myDir\" + $File + ".csv", 6)
    }
    $Excel.Quit()
}

$FileName = "list_of_names"
ExcelToCsv -File $FileName