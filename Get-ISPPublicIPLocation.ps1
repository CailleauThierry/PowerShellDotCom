<#
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	01_28_2021 12:55 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename: 		Get-ISPPublicIPLocation.ps1
	===========================================================================
   .DESCRIPTION
   Identifying Location and Public IP
More
The example below returns your public IP address and location:

 
PS> Invoke-RestMethod -Uri 'ipinfo.io/json'


ip       : 84.183.236.178
hostname : p54b7ecb2.dip0.t-ipconnect.de
city     : Hannover
region   : Lower Saxony
country  : DE
loc      : 52.3705,9.7332
org      : AS3320 Deutsche Telekom AG
postal   : 30159
timezone : Europe/Berlin
readme   : https://ipinfo.io/missingauth  
 
   #>

   Invoke-RestMethod -Uri 'ipinfo.io/json'