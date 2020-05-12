<#
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	05_12_2020 7:42 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename: Get-InstalledSoftware.ps1
	===========================================================================
	.DESCRIPTION
        Example1 of Get-InstalledSoftware... (no name clash with Get-InstalledScript or Get-InstalledModule ) but cmdlet name is already in use in PowerShell Gallery: 
        https://gallery.technet.microsoft.com/scriptcenter/519e1d3a-6318-4e3d-b507-692e962c6666 > this one is not the same it is from a post from yourpowertip@powershell.com>
#>

# read all child keys (*) from all four locations and do not emit
# errors if one of these keys does not exist
Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
                 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
                 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
                 'HKCU:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' -ErrorAction Ignore |
# list only items with the DisplayName
Where-Object DisplayName |
# show these registry values per item
Select-Object -Property DisplayName, DisplayVersion, UninstallString, InstallDate |
# sort by DisplayName
Sort-Object -Property DisplayName  
