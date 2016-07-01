<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	7/1/2016 9:18 AM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
##Sending Emails (and Diagnosing Mail Servers)
#
#Send-MailMessage has been around for many years. It can be used to quickly send an email without the need to have an email client at hand. All you need is an SMTP server. Likewise, it can be used to diagnose problems with a particular mail server:
[cmdletbinding()]
param
(
	[parameter(Mandatory = $true)]
	[String]$SmtpServer = 'relay.company.com',
	[parameter(Mandatory = $true)]
	[String]$To = 'firstname.lastname@company.com',
	[parameter(Mandatory = $true)]
	[String]$From = 'firstname.lastname@company.com',
	[parameter(Mandatory = $true)]
	[String]$Subject = 'Hello!',
	[parameter(Mandatory = $true)]
	[String]$Body = 'This is just a test'
)
Send-MailMessage -SmtpServer $SmtpServer -To $To -From $From -Subject $Subject -Body $Body

#me: this looks promissing under PS v2 and V5
#>> Running (Set-TestEmail.ps1) Script...
#>> Platform: V5 64Bit (STA)
#>> Parameters: -SmtpServer 'relay.company.com' -To 'firstname.lastname@company.com' -From 'firstname.lastname@company.com' -Subject 'Hello!'
#ERROR: Send-MailMessage : The operation has timed out.
#Set-TestEmail.ps1 (29, 1): ERROR: At Line: 29 char: 1
#ERROR: + Send-MailMessage -SmtpServer $SmtpServer -To $To -From $From -Subject ...
#ERROR: + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#ERROR:     + CategoryInfo          : InvalidOperation: (System.Net.Mail.SmtpClient:SmtpClient) [Send-MailMessage], SmtpException
#ERROR:     + FullyQualifiedErrorId : SmtpException, Microsoft.PowerShell.Commands.SendMailMessage
#ERROR:
#
#>> Execution time: 00:01:40
#>> Script Ended
#
#>> Running (Set-TestEmail.ps1) Script...
#>> Platform: V2 64Bit (STA)
#>> Parameters: -SmtpServer 'relay.company.com' -To 'firstname.lastname@company.com' -From 'firstname.lastname@company.com' -Subject 'Hello!'
#ERROR: Send-MailMessage : The operation has timed out.
#ERROR:
#Set-TestEmail.ps1 (29, 17): ERROR: At Line: 29 char: 17
#ERROR: + Send-MailMessage <<<< -SmtpServer $SmtpServer -To $To -From $From -Subject $Subject
#ERROR:     + CategoryInfo          : InvalidOperation: (System.Net.Mail.SmtpClient:SmtpClient) [Send-MailMessage], SmtpException
#ERROR:     + FullyQualifiedErrorId : SmtpException, Microsoft.PowerShell.Commands.SendMailMessage
#ERROR:
#
#>> Execution time: 00:01:41
#>> Script Ended