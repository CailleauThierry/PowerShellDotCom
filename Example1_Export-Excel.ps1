<#
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	08_29_2019 4:45 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename: Example1_Export-Excel.ps1
	===========================================================================
	.DESCRIPTION
		Example1 of Export-Excel From Excel Module
#>

# any object-oriented data will do
# we create some sample records via CSV
# to mimick specific issues
$rawData = @'
Phone,Name
+4915125262524, Tobias
0766256725672, Mary
00496253168722567, Tom
'@ | ConvertFrom-Csv

# create this Excel file
$Path = "$env:temp\report.xlsx"
# make sure the file is deleted so we have no
# effects from previous data still present in the
# file. This requires that the file is not still
# open and locked in Excel
$exists = Test-Path -Path $Path
if ($exists) { Remove-Item -Path $Path }

$rawData |
  Export-Excel -Path $path -ClearSheet -WorksheetName Processes -Show -NoNumberConversion Phone
