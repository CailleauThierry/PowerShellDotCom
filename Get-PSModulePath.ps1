<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	6/10/2016 5:31 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#Check Default PowerShell Module Paths
#
#Sometimes, PowerShell modules ship as MSI packages. When they do, you never know what the installation logic does to your system. Unfortunately, there are module authors who replace rather than add paths to the list of default PowerShell module paths. When this occurs, the module list may no longer contain the default module path for personal modules, and modules stored in the CurrentUser scope fail to load.
#Just check and make sure your default module paths don't miss these important paths:
#PS> $env:PSModulePath -split '; '
$env:PSModulePath -split ';'
#C:\Users\[YOURUSERNAME]\Documents\WindowsPowerShell\Modules
#C:\Program Files\WindowsPowerShell\Modules
#C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\ 
# 
#There can be more paths, but the paths shown should always be present.
