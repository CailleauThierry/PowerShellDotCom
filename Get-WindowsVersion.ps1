<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	09_13_2021 2:45 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	Get-WindowsVersion.ps1
	===========================================================================
	.DESCRIPTION
	Identifying Windows version (Part 3)
In the previous tip we illustrated that accessing the WinRT class AnalyticsInfo seems to be the only supported way to read the current Windows 10 version. Rather than using asynchronous methods like in the previous example, to get just the current Windows 10 version, here is a simpler way:

Note that PowerShell 7 (pwsh.exe) cannot access this API. The code requires Windows PowerShell (powershell.exe).
#>

[int64]$rawVersion = 
  [Windows.System.Profile.AnalyticsInfo,Windows.System.Profile,ContentType=WindowsRuntime ].
  GetMember('get_VersionInfo').Invoke( $Null, $Null ).DeviceFamilyVersion
 
# decode bits to version bytes
$major = ( $rawVersion -band 0xFFFF000000000000l ) -shr 48
$minor = ( $rawVersion -band 0x0000FFFF00000000l ) -shr 32
$build = ( $rawVersion -band 0x00000000FFFF0000l ) -shr 16
$revision =   $rawVersion -band 0x000000000000FFFFl
 
# compose version
$winver = [System.Version]::new($major, $minor, $build, $revision)
$winver  
$PSVersionTable
<# 
.\Get-WindowsVersion.ps1

Major  Minor  Build  Revision
-----  -----  -----  --------
10     0      19042  1165    

Key   : PSVersion
Value : 5.1.19041.1151       
Name  : PSVersion


Key   : PSEdition
Value : Desktop  
Name  : PSEdition


Key   : PSCompatibleVersions
Value : {1.0, 2.0, 3.0, 4.0...}
Name  : PSCompatibleVersions


Key   : BuildVersion
Value : 10.0.19041.1151
Name  : BuildVersion


Key   : CLRVersion
Value : 4.0.30319.42000
Name  : CLRVersion


Key   : WSManStackVersion
Value : 3.0
Name  : WSManStackVersion


Key   : PSRemotingProtocolVersion
Value : 2.3
Name  : PSRemotingProtocolVersion


Key   : SerializationVersion
Value : 1.1.0.1
Name  : SerializationVersion
#>