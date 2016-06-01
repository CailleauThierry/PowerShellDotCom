<#	
	.NOTES
	===========================================================================
	 Created with: 	yourpowertip@powershell.com
	 Created on:   	6/1/2016 5:03 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#requires -Version 1 
#Requires -RunAsAdministrator 
# must run with admin privileges! 

Stop-Service TrustedInstaller
Remove-Item -Path C:\Windows\Logs\CBS\CBS.log
Start-Service TrustedInstaller

#To delete the log file, you just need to make sure that the trusted installer isn't accessing (and locking) the file.