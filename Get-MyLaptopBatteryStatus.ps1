<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	02_13_2023_09:47
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	Get-MyLaptopBatteryStatus.ps1
	===========================================================================
	.DESCRIPTION
		hecking Battery Wear and Quality
All Versions
If you run a laptop you can easily ask WMI for battery status such as charging status. With a little bit more work, though, you can also check the wear of your battery and find out whether it’s time to replace the battery.
Essentially, the script below uses different WMI classes to determine your battery nominal capacity and its real capacity, then calculating its effective capacity in percent. Any percentage below 80% typically indicates a high degree of wear and need for battery replacement.
#>
$designCap = Get-WmiObject -Class "BatteryStaticData" -Namespace "ROOT\WMI" | 
Group-Object -Property InstanceName -AsHashTable -AsString
    
Get-CimInstance -Class "BatteryFullChargedCapacity" -Namespace "ROOT\WMI" | 
Select-Object -Property InstanceName, FullChargedCapacity, DesignedCapacity, Percent |
ForEach-Object {
    $_.DesignedCapacity = $designCap[$_. InstanceName].DesignedCapacity
    $_.Percent = [Math]::Round( ( $_.FullChargedCapacity*100/$_.DesignedCapacity), 2)
    $_
}  

<# \Documents\WindowsPowerShell\Scripts\PowerShellDotCom\Get-MyLaptopBatteryStatus.ps1'

InstanceName     FullChargedCapacity DesignedCapacity Percent
------------     ------------------- ---------------- -------
ACPI\PNP0C0A\1_0               53398            83995   63.57 #>