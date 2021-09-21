<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	09_21_2021 1:00 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	Get-LocalAdministratorAccount.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
<# Identifying Local Administrator Account
All Versions
There are a few default accounts on Windows machines such as the local “Administrator” account. While this account exists by default, its name can vary from culture to culture, and its name can also be renamed. 
To always identify the local Administrator account regardless of its name, search local accounts by SID (security identifier). The local Administrator account SID always starts with ‘S-1-5-‘ and uses the RID ‘-500’:
PS> Get-Localuser | Where-Object Sid -like 'S-1-5-*-500'
 
Name    Enabled Description
----    ------- -----------
TobiasA False   Built-in account for administering the computer/domain 
 #>

Get-Localuser | Where-Object Sid -like 'S-1-5-*-500'

<#  Name    Enabled Description
 ----    ------- -----------
 mycompanyadmin True    Built-in account for administering the computer/domain
 
 
 PS C:\WINDOWS\system32> $PSVersionTable
 
 Name                           Value
 ----                           -----
 PSVersion                      5.1.19041.1237 #>