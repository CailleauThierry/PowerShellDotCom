<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	6/29/2016 4:20 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#Saving Multiple Credentials
#
#Thanks to Jaap Brasser's finding, here is an easy way of encrypting a bunch of credentials:

#$CredPath = "$home\Desktop\mycreds.xml"
#$creds = @{
#  Local = Get-Credential -Message LocalAccount
#  Remote = Get-Credential -Message RemoteAccount
#  Domain = Get-Credential -Message DomainAccount
#}
#
#$creds | Export-Clixml -Path $CredPath

#after setting the path output as $CredPath insteads of $OutPath
#>> Running (Set-LocalCredentials.ps1) Script...
#>> Platform: V5 64Bit (STA)
#
#>> Execution time: 00:00:43
#>> Script Ended
# me   : Results:
#>> Running (Set-LocalCredentials.ps1) Script...
#>> Platform: V5 64Bit (STA)
#ERROR: Export-Clixml : Cannot bind argument to parameter 'Path' because it is null.
#Set-LocalCredentials.ps1 (24, 30): ERROR: At Line: 24 char: 30
#ERROR: + $creds | Export-Clixml -Path $OutPath
#ERROR: +                              ~~~~~~~~
#ERROR:     + CategoryInfo          : InvalidData: (:) [Export-Clixml], ParameterBindingValidationException
#ERROR:     + FullyQualifiedErrorId : ParameterArgumentValidationErrorNullNotAllowed, Microsoft.PowerShell.Commands.ExportClixmlCommand
#ERROR:
#
#>> Execution time: 00:01:12
#>> Script Ended

#------------------------------------------
 
#To read in these credentials, use this:
 
$CredPath = "$home\Desktop\mycreds.xml"
$creds = Import-Clixml -Path $CredPath
 
$creds.Local
$creds.Remote
$creds.Domain
 
# example 
Get-WmiObject -Class Win32_BIOS -ComputerName server1 -Credential $creds.Remote

#me: with no remote "server1" server available (after running Get-LocalCredentials.ps1 sucessfully)
#>> Running (Get-LocalCredentials.ps1) Script...
#>> Platform: V5 64Bit (STA)
#
#UserName                     Password
#-------- --------
#Local    System.Security.SecureString
#Remote   System.Security.SecureString
#Domain   System.Security.SecureString
#ERROR: Get-WmiObject : The RPC server is unavailable. (Exception from HRESULT: 0x800706BA)
#Get-LocalCredentials.ps1 (58, 1): ERROR: At Line: 58 char: 1
#ERROR: + Get-WmiObject -Class Win32_BIOS -ComputerName server1 -Credential $cr ...
#ERROR: + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#ERROR:     + CategoryInfo          : InvalidOperation: (:) [Get-WmiObject], COMException
#ERROR:     + FullyQualifiedErrorId : GetWMICOMException, Microsoft.PowerShell.Commands.GetWmiObjectCommand
#ERROR:
#
#
#
#>> Execution time: 00:00:12
#>> Script Ended
 
#Note that the passwords are safely encrypted with your identity and the machine identity, so you can read in the credentials only on the machine where they were generated, and only if you are the same person that saved them.
