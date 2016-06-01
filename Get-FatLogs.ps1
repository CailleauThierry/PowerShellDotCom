<#	
	.NOTES
	===========================================================================
	 Created on:   	5/30/2016 5:09 PM
	 Created by:   	Powershell.com <yourpowertip@powershell.com>
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file. Does not work in Posh v2 64-bits
#>
#requires -Version 3 
#Requires -RunAsAdministrator 
# must run with admin privileges! 


# use an ordered hash table to store logging info 
$sizes = [Ordered]@{ }



Get-ChildItem -Path $env:windir\logs\cbs\ -Filter *.cab |
ForEach-Object {
	try
	{
		$fileSize = $_.Length
		# ATTENTION: REMOVE -WHATIF AT OWN RISK
		# WILL DELETE FILES AND RETRIEVE STORAGE SPACE
		# ONLY AFTER YOU REMOVED -WHATIF
		Remove-Item -Path $_.FullName -ErrorAction SilentlyContinue -WhatIf
		$sizes['Retrieved'] += $fileSize
	}
	catch { }
}

# turn bytes into MB 
$Sizes['RetrievedMB'] = [Math]::Round(($Sizes['Retrieved']/1MB), 1)

New-Object -TypeName PSObject -Property $sizes

#>> Running (Get-FatLogs.ps1) Script...
#>> Platform: V5 64Bit
#What if: Performing the operation "Remove File" on target "C:\windows\logs\cbs\CbsPersist_20160526053632.cab".
#What if: Performing the operation "Remove File" on target "C:\windows\logs\cbs\CbsPersist_20160526222458.cab".
#
#Retrieved RetrievedMB
#--------- -----------
#4614859         4.4
#
#
#
#>> Execution time: 00:00:01
#>> Script Ended