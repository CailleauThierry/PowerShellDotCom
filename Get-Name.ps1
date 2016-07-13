<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	7/13/2016 8:58 AM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#Creating Custom Mandatory Parameters
#All PowerShell Versions
#
#While you can declare a parameter as mandatory, this leaves not much control to you. If the user omits the mandatory parameter, PowerShell prompts the user with its ugly default prompt.
#Here is an alternative that allows you to define your very own prompt in case a user did not submit the parameter:

function Get-Name
{
	#Content
	param
	(
		$Name = $(
			Write-Host 'Please, enter your name: ' -ForegroundColor Yellow -NoNewLine
			Read-Host
		)
	)
	
	"You entered: $Name"
}

#When you call Get-Name and submit an argument, the function runs silently. If you do not specify your name, it asks for it and uses the colors and prompt text that you define.
#
# me: I tested it on PS v2 and V5 (64-bits)
# Note 1: Get-Name is not an existing cmdlet in PS v2 or V5
# Note 2: $Name is of no type. It oculd be astring or a full PSObject