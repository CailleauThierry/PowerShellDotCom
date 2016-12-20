<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	12/20/2016 5:25 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#Test for File or Folder
#All Versions
#Test-Path can check whether a file or folder exists. If you add -PathType and specify Leaf (for files) or Container (for folders), the result can be even more specific:
$path = 'c:\windows'

Test-Path -Path $path
Test-Path -Path $path -PathType Leaf # since "c:\windows" is not a "file" it return false, even if there are files (and folders) in "c:\windows")
Test-Path -Path $path -PathType Container
#Tested with PS v5 and v2 64-bits
<#>> Running (Get-ExistingFileOrFolder.ps1) Script...
>> Platform: V5 64Bit
True
False
True

>> Execution time: < 1 second
>> Script Ended#>
<#>> Running (Get-ExistingFileOrFolder.ps1) Script...
>> Platform: V2 64Bit
True
False
True

>> Execution time: 00:00:01
>> Script Ended#>
