<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	6/15/2016 5:43 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#Minimizing All Windows (Part 2)
#
#If all you need to do is minimizing all open windows, there is the Shell.Application COM object. PowerShell can access its methods via New-Object:

$shell = New-Object -ComObject Shell.Application
$shell.MinimizeAll()
Start-Sleep -Seconds 2
$shell.UndoMinimizeALL()

#This sample minimizes all open application windows, waits for two seconds, and restores them all.

# Me: only minimizes all open windows for the time the script runs in V2 and V 5 
