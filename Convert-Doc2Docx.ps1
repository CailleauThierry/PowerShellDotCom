<#
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	03_08_2021 4:20 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename: 		Convert-Doc2Docx.ps1
	===========================================================================
   .DESCRIPTION
   There are still floating around numerous Microsoft Office documents in old file formats (.doc instead of .docx).

Here is a simple PowerShell function that takes an old .doc Word document, converts it and saves the converted document in .docx format. Provided the old Word document isn’t locked, this process is completely invisible and can run unattended:
   .EXAMPLE
   To conver all the .doc file present in the current folder and all its sub-folders (Note: this does not create a list of files that were converted)

   Get-ChildItem -Path ./  -Recurse -Include *.doc | Convert-Doc2Docx

   Which you could follow by removing the old .doc files

   Get-ChildItem -Path ./  -Recurse -Include *.doc | Remove-Item    

#>

   function Convert-Doc2Docx
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
       $word = New-Object -ComObject Word.Application
     }
   
     process
     {
   
       
       $pathOut = [System.IO.Path]::ChangeExtension($Path, '.docx')
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
       $doc = $word.Documents.Open($Path)
       $name = Split-Path -Path $Path -Leaf
       Write-Progress -Activity 'Converting' -Status $name
       $doc.Convert()
       $doc.SaveAs([ref]([string]$PathOut),[ref]16)
       $word.ActiveDocument.Close()
   
     }
     end
     {
       $word.Quit()
     }
   }  
   