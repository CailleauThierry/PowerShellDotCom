<#	
	.NOTES
	===========================================================================
	 From: yourpowertip@powershell.com
     Created on:   	6/2/2016 4:19 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#requires -Version 3 


$downloads = "$Home\Downloads"

Get-ChildItem -Path $downloads -File -Recurse |
Sort-Object -Property Length -Descending |
Out-GridView -Title 'Choose stuff to remove. Hold CTRL to select multiple files' -OutputMode Multiple |
# remove -Whatif to actually delete files!
Remove-Item -WhatIf
#When you run this code, a grid view window opens and shows all files from your download folder, sorted by size in descending order. So the largest files appear on top.
#Now just hold CTRL and click all files that you do not need anymore. Once you click OK in the lower right corner of the grid view window, the files are deleted.
#Well, not really. To safely play with the code, we added -WhatIf to Remove-Item. Remove -WhatIf to enable deleting the files you selected.
