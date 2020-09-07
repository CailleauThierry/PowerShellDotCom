<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	09_07_2020 4:45 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	Get-InstalledAV.ps1
	===========================================================================
	.DESCRIPTION
		A PowerShell one-liner can help you identify the antivirus product installed on a Windows box:
PS> Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntiVirusProduct  
Add the -ComputerName parameter to query remote systems.
Note that this line returns only antivirus products that properly registered. The result looks similar to this and provides you with AV product and install location:

#>

Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntiVirusProduct

<# 
PS C:\WINDOWS\system32> Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntiVirusProduct


displayName              : Sentinel Agent
instanceGuid             : {3D89204D-BBC3-1E6D-4923-AC225AFFE196}
pathToSignedProductExe   : C:\Program Files\SentinelOne\Sentinel Agent 4.1.4.82\SentinelRemediation.exe
pathToSignedReportingExe : C:\Program Files\SentinelOne\Sentinel Agent 4.1.4.82\SentinelAgent.exe
productState             : 266240
timestamp                : Sun, 06 Sep 2020 11:23:24 GMT
PSComputerName           :

displayName              : Windows Defender
instanceGuid             : {D68DDC3A-831F-4fae-9E44-DA132C1ACF46}
pathToSignedProductExe   : windowsdefender://
pathToSignedReportingExe : %ProgramFiles%\Windows Defender\MsMpeng.exe
productState             : 393472
timestamp                : Fri, 28 Aug 2020 13:23:01 GMT
PSComputerName           :



PS C:\WINDOWS\system32> 
#>