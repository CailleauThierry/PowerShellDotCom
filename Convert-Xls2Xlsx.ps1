<#
	.NOTES
	===========================================================================
	 	 Created on:   	03_08_2021 4:20 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename: 		Convert-Xls2Xlsx.ps1 (not functional) based on Convert-Doc2Docx.ps1 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	===========================================================================
   .DESCRIPTION
   There are still floating around numerous Microsoft Office Excel Sheets in old file formats (.xls instead of .xlsx).

Here is a simple PowerShell function that takes an old .xls Word Excel Sheet, converts it and saves the converted Excel Sheet in .xlsx format. Provided the old Word Excel Sheet isn’t locked, this process is completely invisible and can run unattended:
   .EXAMPLE
   To conver all the .xls file present in the current folder and all its sub-folders (Note: this does not create a list of files that were converted)

   Get-ChildItem -Path ./  -Recurse -Include *.xls | Convert-Xls2Xlsx

   Which you could follow by removing the old .xls files

   Get-ChildItem -Path ./  -Recurse -Include *.xls | Remove-Item    

#>

   function Convert-Xls2Xlsx
   {
     param
     (
       [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
       [string]
       [Alias('FullName')]
       $Path,
       
       [string]
       $DestinationFolder
       
     )
     begin
     {
       $excelsheet = New-Object -ComObject Excel.Application
     }
   
     process
     {
   
       
       $pathOut = [System.IO.Path]::ChangeExtension($Path, '.xlsx')
       if ($PSBoundParameters.ContainsKey('DestinationFolder'))
       {
         $exists = Test-Path -Path $DestinationFolder -PathType Container
         if (!$exists)
         {
           throw "Folder not found: $DestinationFolder"
         }
         $name = Split-Path -Path $pathOut -Leaf
         $pathOut = Join-Path -Path $DestinationFolder -ChildPath $name
       }
       $doc = $excelsheet.Workbook.Open($Path)
       $name = Split-Path -Path $Path -Leaf
       Write-Progress -Activity 'Converting' -Status $name
       $doc.Converter()
       $doc.SaveAs([ref]([string]$PathOut),[ref]16)
       $excelsheet.ActiveWorkbook.Close()
   
     }
     end
     {
       $excelsheet.Quit()
     }
   }  
   