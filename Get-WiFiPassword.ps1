<#
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	08_03_2020 2:02 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename: 		Get-WiFiPassword.ps1
	===========================================================================
	.DESCRIPTION
		In the previous tip we used netsh.exe to dump Wi-Fi profiles. Let’s take it a step further and expose the cached passwords:
		This is just an example how string information returned by console applications such as netsh.exe can be processed by PowerShell. 
		There are chances you run into challenges, too: when Wi-Fi profile names use special characters such as apostrophes, they may not be retrievable via netsh.exe.
#>

# get Wi-Fi profiles
 $profiles = netsh wlan show profiles | Select-String ":(.{1,})$" | ForEach-Object { ($_.Line -split ': ')[-1] }
 
 # get cleartext password for each profile
 Foreach ($profile in $profiles)
 {
       $password = (@(netsh wlan show profile name="$profile" key=clear) -like '*Key Content*' -split ': ')[-1]
       [PSCustomObject]@{
             Profile = $profile
             Password = $password
       }
 }  
