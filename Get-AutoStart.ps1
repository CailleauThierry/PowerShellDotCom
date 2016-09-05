<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	9/5/2016 4:45 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#Finding Auto Starts
#PowerShell 3+
#
#If you'd like to know which programs start automatically on your machine, WMI may help:
#PS C:\> Get-CimInstance -ClassName Win32_StartupCommand | Select-Object -Property Name, Location, User, Command, Description
# 
# 
#Name        : OneDrive
#Location    : HKU\S-1-5-21-2012478179-265285931-690539891-1001\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
#User        : DESKTOP-7AAMJLF\tobwe
#Command     : "C:\Users\tobwe\AppData\Local\Microsoft\OneDrive\OneDrive.exe" /background
#Description : OneDrive
# 
#Name        : Bluetooth
#Location    : Common Startup
#User        : Public
#Command     : C:\PROGRA~1\WIDCOMM\BLUETO~1\BTTray.exe 
#Description : Bluetooth
# 
#Name        : Snagit 12
#Location    : Common Startup
#User        : Public
#Command     : C:\PROGRA~2\TECHSM~1\SNAGIT~1\Snagit32.exe 
#Description : Snagit 12
# 
#Name        : RTHDVCPL
#Location    : HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
#User        : Public
#Command     : "C:\Program Files\Realtek\Audio\HDA\RtkNGUI64.exe" -s
#Description : RTHDVCPL
# 
#... 
#

Get-CimInstance -ClassName Win32_StartupCommand | Select-Object -Property Name, Location, User, Command, Description

# me: tested on PS v5 (64-bits)

#>> Running (Get-AutoStart.ps1) Script...
#>> Platform: V5 64Bit (STA)
#
#
#Name        :
#Location    : HKU\S-1-5-18\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
#User        : NT AUTHORITY\SYSTEM
#Command     :
#Description :
#
#Name        : CLCL - Shortcut
#Location    : Startup
#User        : SSV\TCailleau
#Command     : CLCL - Shortcut.lnk
#Description : CLCL - Shortcut