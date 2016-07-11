<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	7/11/2016 4:05 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#requires -Version 2
#Use a Shorter Prompt
#All PowerShell Versions
#
#By default, PowerShell displays the current path in its input prompt which wastes as lot of space. When you overwrite the "prompt" function, you control how the prompt is displayed. Here is a prompt that displays the current location in the title bar instead. It also beeps after a command completed.
function prompt
{
	'PS> '
	$host.UI.RawUI.WindowTitle = Get-Location
	[Console]::Beep()
}
# me usage: . C:\Users\your_user_name\Documents\WindowsPowerShell\Scripts\PowerShellDotCom\Set-ShorterPrompt.ps1
# works great in PS v2 and v5 (64-bits)