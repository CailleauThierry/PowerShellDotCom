<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	6/21/2016 4:32 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

#Using Enumerations
#
#Beginning with PowerShell 5.0, you can use the new keyword "enum" to create enumerations. They can be useful for parameter validation:


#requires -Version 5 
enum MyFavoriteCities
{
	Hannover
	Seattle
	London
	NewYork
}


function Select-City
{
	param
	(
		[MyFavoriteCities][Parameter(Mandatory = $true)]
		$City
	)
	
	"You chose $City"
}

#The -City parameter now only accepts the values listed in the enumeration, and in the PowerShell ISE, you even get intelliSense.
#
#However, for this to work the enum needs to be defined before you run the function.
#PS C:\> . C:\Users\you\Documents\WindowsPowerShell\Scripts\PowerShellDotCom\Get-Enumerate.ps1
#PS C:\> Select-City
#
#cmdlet Select-City at command pipeline position 1
#Supply values for the following parameters:
#City: 1
#You chose Seattle
#PS C:\>