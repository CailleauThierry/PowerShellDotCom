<#
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	01_06_2020 10:31 AM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename: Get-InstalledHotfix.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

Get-WinEvent @{
  Logname='System'
  ID=19
  ProviderName='Microsoft-Windows-WindowsUpdateClient'
} | ForEach-Object  {
  [PSCustomObject]@{
    Time = $_.TimeCreated
    Update  = $_.Properties.Value[0]
  }
}
<# Obviously, when the System event log was cleared, the results are no longer complete. Also, the log simply logs any update installation, so over time new updates can replace older updates.
To guarantee you get a complete list of currently installed updates, you’d have to ask the Windows Update Client to re-construct the list from the actual installed updates which takes a lot longer:#>
$result = (New-Object -ComObject Microsoft.Update.Session).CreateupdateSearcher().Search("IsInstalled = 1").Updates |
  Select-Object LastDeploymentChangeTime, Title, Description , MsrcSeverity

$result | Out-GridView -Title 'Installed Updates'
