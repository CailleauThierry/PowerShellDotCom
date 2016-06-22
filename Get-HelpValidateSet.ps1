<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	6/22/2016 5:41 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

#ValidateSet Instead of Enum
#
#In the previous tip we illustrated how the new "enum" keyword works in PowerShell 5.0 to set the values that are assignable to a parameter. This has two backdraws: it works in PowerShell 5.0 only, and the enum needs to be declared before you can run the function.
#If all you want is limiting choices, you can use a ValidateSet attribute instead. It is supported in older PowerShell versions and part of the function code:

#requires -Version 2 
function Select-City
{
	param
	(
		[ValidateSet('Hannover', 'Seattle', 'London', 'NewYork')]
		[Parameter(Mandatory = $true)]
		$City
	)
	
	"You chose $City"
}

#ValidateSets provide smart IntelliSense in PowerShell ISE, just like enumerations do.
#me: the result below shows that the tab completion on ValidateSet is sorted alphabetically in PS v5, but the tab completion does not work in the PS v2 console, even is the validation work
#Windows PowerShell
#Copyright (C) 2015 Microsoft Corporation. All rights reserved.
#
#PSVERSION: 5.0.10586.117
#PS C:\> . C:\Users\you\Documents\WindowsPowerShell\Scripts\PowerShellDotCom\Get-HelpValidateSet.ps1
#PS C:\> Select-City Hannover
#You chose Hannover
#PS C:\> Select-City London
#You chose London
#PS C:\> Select-City NewYork
#You chose NewYork
#PS C:\> Select-City Seattle
#You chose Seattle
#PS C:\>

#PSVERSION: 2.0
#PS C:\> . C:\Users\you\Documents\WindowsPowerShell\Scripts\PowerShellDotCom\Get-HelpValidateSet.ps1
#PS C:\> Select-City Hannover
#You chose Hannover
#PS C:\> Select-City Paris
#Select-City : Cannot validate argument on parameter 'City'. The argument "Paris" does not belong to the set "Hannover,Seattle,London,NewYork" specified by the ValidateSet attribute. Supply an argumen
#t that is in the set and then try the command again.
#At line:1 char:12
#+ Select-City <<<<  Paris
#+ CategoryInfo          : InvalidData: (:) [Select-City], ParameterBindingValidationException
#+ FullyQualifiedErrorId : ParameterArgumentValidationError, Select-City
#
#PS C:\>