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
$path = "$env:windir\logs\cbs\"

$space = Get-ChildItem -Path $path -Filter cbspersist*.cab -File |
Measure-Object -Property Length -Sum |
Select-Object -Property Count, Sum

'{0} backed up log files eat up {0:n1} MB' -f $space.Count, ($space.Sum/1MB)

#>> Running (Get-FatLogs.ps1) Script...
#>> Platform: V5 64Bit
#2 backed up log files eat up 2.0 MB
#>> Execution time: 00:00:03
#>> Script Ended
