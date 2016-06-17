<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	6/17/2016 6:45 AM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

#Reading Excel Cells
#
#The fastest way to read data from an Excel spreadsheet is to export the data to CSV, then use Import-CSV. However, sometimes the data in an Excel sheet is not tabular, or you want to access specific cells. Here is a sample that accesses cells directly:
param
(
	[parameter(Mandatory = $true)]
	[string]$ExcelPath = 'c:\path..to..some..excel..file.xlst',
	[parameter(Mandatory = $false)]
	[int]$startLine = 1,			# pick the start line to read from Excel 
	[parameter(Mandatory = $false)]
	[int]$column = 1 				# pick the column to read from Excel

)

$excel = New-Object -ComObject Excel.Application

# keep Excel invisible 
# $excel.Visible = $true 
$workbook = $excel.Workbooks.Open($ExcelPath)

# read column line by line until an empty cell is found 
for ($i = $startLine; $i -lt 10000; $i += 1)
{
	$cell = $workbook.ActiveSheet.Cells.Item($i, $column).Text
	if ($cell.Trim() -eq '') { break }
	$cell
}
$workbook.Close($false)
$excel.Quit()

#Make sure you specify an existing Excel file. Also, you may want to adjust $startLine (the line in the sheet where the code starts), and $column (the column the code outputs).
#Note that direct access to Excel sheets requires that you have Excel installed. It also is somewhat slow. Uncomment the line to make Excel visible in case you want to debug the code behavior and see the Excel sheet while it is being read.
# me: This returns thr first cell in a raw from the first column in the console as a "TypeName: System.String"
