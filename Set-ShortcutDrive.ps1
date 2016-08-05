<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	8/5/2016 4:23 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#Creating Shortcut Drives
#All PowerShell Versions
#
#Simply add a new drive to one of the file locations you often visit:

# create folder if it does not exist yet 
$path = "$home\Documents\Scripts"
$exists = Test-Path -Path $path
if (!$exists)
{
	$null = New-Item -ItemType Directory -Path $path
}

# create new scripts: drive 
New-PSDrive -Name scripts -PSProvider FileSystem -Root "$home\Documents\Scripts"

dir scripts:

#New-PSDrive creates drives to all the locations you need to access frequently. Note that drives created with New-PSDrive are available in PowerShell only. The new drive is available only in the current PowerShell session. You may want to place this command into your profile script (path to a profile script is found in $profile and may need to be created if it does not yet exist).
#me: Tested under PS v2 and v5 (64-bits)
# I have a Scripts Dir under C:, but because my default working dir is Z: (with PS v2) it created a new directory there. With PS v5 it creates the directory under my C: drive ($home is C:\User\username as you would expect)
#>> Running (Set-ShortcutDrive.ps1) Script...
#>> Platform: V2 64Bit (STA)
#
#Name           Used (GB)     Free (GB) Provider      Root                                                                                       CurrentLocation
#---- --------- --------- -------- ---- ---------------
#scripts             0.00        324.74 FileSystem    Z:\Documents\Scripts
#
#
#
#>> Execution time: 00:00:04
#>> Script Ended
#>> Running (Set-ShortcutDrive.ps1) Script...
#>> Platform: V5 64Bit (STA)
#
#Name           Used (GB)     Free (GB) Provider      Root                                                                                       CurrentLocation
#---- --------- --------- -------- ---- ---------------
#scripts             0.00        239.69 FileSystem    C:\User\username\Documents\Scr...
#
#
#
#>> Execution time: 00:00:01
#>> Script Ended
