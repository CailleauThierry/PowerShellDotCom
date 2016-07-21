<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	7/21/2016 4:25 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#requires -Version 2
#Reading NTFS Permissions
#PowerShell 2+
#
#NTFS permissions are represented by complex object hierarchies that are hard to read. A much simpler way is to output the structure in an SDDL (Security Descriptor Definition Language) format:

$sd = Get-Acl -Path c:\windows
$sd.GetSecurityDescriptorSddlForm('All')

#The result looks similar to this:
#
#O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464G:S-1-5-80-9560
#08885 - 3418522649 - 1831038044 - 1853292631-2271478464D:PAI(A; OICIIO; GA;;; CO)(A; OICI
#	IO; GA;;; SY)(A;; 0x1301bf;;; SY)(A; OICIIO; GA;;; BA)(A;; 0x1301bf;;; BA)(A; OICIIO; GXGR
#	;;; BU)(A;; 0x1200a9;;; BU)(A; CIIO; GA;;; S-1-5-80-956008885-3418522649-1831038044-1
#	853292631 - 2271478464)(A;; FA;;; S-1-5-80-956008885-3418522649-1831038044-18532926
#	31 - 2271478464)(A;; 0x1200a9;;; AC)(A; OICIIO; GXGR;;; AC)
#
#Admitted, this does not look very friendly, either. But now you can analyze the security settings with pure text methods, for example using regular expressions.
#
#me: tested with PS v2 and v5 (64-bits)