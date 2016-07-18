<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	7/18/2016 4:06 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#requires -Version 3
#Test-Driving PowerShellGet Module
#PowerShell 3+
#
#PowerShell 5.0 ships with a new module called PowerShellGet, and on older PowerShell versions, you can easily download and install this module from www.powershellgallery.com.
#With it, you have a bunch of new cmdlets that can search for, find, download, and install modules from public and private repositories.
#Here is a quick transcript that walks you through the steps and helps you discover the immense usefulness of PowerShellGet:
# if you don't have these cmdlets, go to 
# http://www.powershellgallery.com and download PowerShellGet! 
# it is included in PowerShell 5.0 and available as MSI package for 
# older PowerShell versions! 

# find modules by using a keyword 
Find-Module *local*

# take a look at details for a specific module 
Find-Module LocalUserManagement | Select-Object -Property *

# download and install a module that you trust 
Install-Module localusermanagement -Scope CurrentUser

# verify the installation 
Get-Module localusermanagement -ListAvailable

# find all new commands exported by the module 
Get-Command -Module localusermanagement

# run one of the new commands 
Test-IsAdministrator
#me: returns true in PS v5 64-bits console
#me: tested on PS v5
#>> Running (Test-DrivingPowerShellGet.ps1) Script...
#>> Platform: V5 64Bit (STA)
#
#Version    Name                                Type       Repository           Description
#------- ---- ---- ---------- -----------
#3.0        LocalUserManagement                 Module     PSGallery            a module that performs various local user management functions
#2.0.0      LocalDev                            Module     PSGallery            Useful utilites for local azure automation development
#1.2        LocalMachine                        Module     PSGallery            Simple management functions for accounts and settings on a local machine.
#1.6        localaccount                        Module     PSGallery            A Simple module to allow the management of local users and groups on a computer
#0.0.6      TelligentLocalInstance              Module     PSGallery            Telligent Instance Manager allows you to create and manage local Telligent Co...
#1.0.1      cLocalGroup                         Module     PSGallery            The cLocalGroup module contains the cLocalGroup DSC resource that provides a ...
#1.0.1      cLocalFileShare                     Module     PSGallery            The cLocalFileShare module contains the cLocalFileShare DSC resource that pro...
#
#Name                       : LocalUserManagement
#Version                    : 3.0
#Type                       : Module
#Description                : a module that performs various local user management functions
#Author                     : ed wilson
#CompanyName                : EdWilson
#Copyright                  : 2014
#PublishedDate              : 5/6/2014 9:44:08 PM
#LicenseUri                 :
#ProjectUri                 :
#IconUri                    :
#Tags                       : { }
#Includes                   : { Function, DscResource, Cmdlet, Workflow... }
#PowerShellGetFormatVersion :
#ReleaseNotes               :
#Dependencies               : { }
#RepositorySourceLocation   : https://www.powershellgallery.com/api/v2/
#Repository                 : PSGallery
#PackageManagementProvider  : NuGet
#AdditionalMetadata         : { versionDownloadCount, summary, ItemType, copyright... }
#
#
#Name              : LocalUserManagement
#Path              : C:\Users\tcailleau\Documents\WindowsPowerShell\Modules\LocalUserManagement\3.0\LocalUserManagement.psd1
#Description       : a module that performs various local user management functions
#Guid              : 917ef4b1-5c04-43b5-b346-ede46df7282c
#Version           : 3.0
#ModuleBase        : C:\Users\tcailleau\Documents\WindowsPowerShell\Modules\LocalUserManagement\3.0
#ModuleType        : Script
#PrivateData       :
#AccessMode        : ReadWrite
#ExportedAliases   : { }
#ExportedCmdlets   : { }
#ExportedFunctions : {
#	[New-LocalUser, New-LocalUser], [New-LocalGroup, New-LocalGroup], [Set-LocalGroup, Set-LocalGroup], [Set-LocalUserPassword,
#	Set-LocalUserPassword]...
#}
#ExportedVariables : { }
#NestedModules     : { }
#
#
#ScriptBlock         :
#                       <#
#                         .Synopsis
#                          This function creates a local group
#                         .Description
#                          This function creates a local group
#                         .Example
#                          New-LocalGroup -GroupName "mygroup" -description "cool local users"
#                          Creates a new local group named mygroup with a description of cool local users.
#                         .Parameter ComputerName
#                          The name of the computer upon which to create the group
#                         .Parameter GroupName
#                          The name of the Group to create
#                         .Parameter description
#                          The description for the newly created group
#                         .Notes
#                          NAME:  New-LocalGroup
#                          AUTHOR: ed wilson, msft
#                          LASTEDIT: 06/29/2011 10:07:42
#                          KEYWORDS: Local Account Management, Groups
#                          HSG: HSG-06-30-11
#                         .Link
#                           Http://www.ScriptingGuys.com/blog
#                       #Requires -Version 2.0
#                       #>
#[CmdletBinding()]
#Param (
#	[Parameter(Position = 0,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$GroupName,
#	[string]$computerName = $env:ComputerName,
#	[string]$description = "Created by PowerShell"
#)
#
#$adsi = [ADSI]"WinNT://$computerName"
#$objgroup = $adsi.Create("Group", $groupName)
#$objgroup.SetInfo()
#$objgroup.description = $description
#$objgroup.SetInfo()
#
#
#CmdletBinding       : True
#DefaultParameterSet :
#Definition          :
#                       <#
#                         .Synopsis
#                          This function creates a local group
#                         .Description
#                          This function creates a local group
#                         .Example
#                          New-LocalGroup -GroupName "mygroup" -description "cool local users"
#                          Creates a new local group named mygroup with a description of cool local users.
#                         .Parameter ComputerName
#                          The name of the computer upon which to create the group
#                         .Parameter GroupName
#                          The name of the Group to create
#                         .Parameter description
#                          The description for the newly created group
#                         .Notes
#                          NAME:  New-LocalGroup
#                          AUTHOR: ed wilson, msft
#                          LASTEDIT: 06/29/2011 10:07:42
#                          KEYWORDS: Local Account Management, Groups
#                          HSG: HSG-06-30-11
#                         .Link
#                           Http://www.ScriptingGuys.com/blog
#                       #Requires -Version 2.0
#                       #>
#[CmdletBinding()]
#Param (
#	[Parameter(Position = 0,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$GroupName,
#	[string]$computerName = $env:ComputerName,
#	[string]$description = "Created by PowerShell"
#)
#
#$adsi = [ADSI]"WinNT://$computerName"
#$objgroup = $adsi.Create("Group", $groupName)
#$objgroup.SetInfo()
#$objgroup.description = $description
#$objgroup.SetInfo()
#
#
#Options             : None
#Description         :
#Verb                : New
#Noun                : LocalGroup
#HelpFile            :
#OutputType          : { }
#Name                : New-LocalGroup
#CommandType         : Function
#Source              : localusermanagement
#Version             : 3.0
#Visibility          : Public
#ModuleName          : localusermanagement
#Module              : localusermanagement
#RemotingCapability  : SupportedByCommand
#Parameters          : {
#	[GroupName, System.Management.Automation.ParameterMetadata], [computerName, System.Management.Automation.ParameterMetadata],
#	[description, System.Management.Automation.ParameterMetadata], [ErrorAction, System.Management.Automation.ParameterMetadata]...
#}
#ParameterSets       : { [- GroupName] <string> [-computerName <string>] [-description <string>] [<CommonParameters>] }
#HelpUri             : Http://www.ScriptingGuys.com/blog
##Requires
#
#
#ScriptBlock         :
#                        <#
#                         .Synopsis
#                          This function creates a local user
#                         .Description
#                          This function creates a local user
#                         .Example
#                          New-LocalUser -userName "ed" -description "cool Scripting Guy" `
#                              -password "password"
#                          Creates a new local user named ed with a description of cool scripting guy
#                          and a password of password.
#                         .Parameter ComputerName
#                          The name of the computer upon which to create the user
#                         .Parameter UserName
#                          The name of the user to create
#                         .Parameter password
#                          The password for the newly created user
#                         .Parameter description
#                          The description for the newly created user
#                         .Notes
#                          NAME:  New-LocalUser
#                          AUTHOR: ed wilson, msft
#                          LASTEDIT: 06/29/2011 10:07:42
#                          KEYWORDS: Local Account Management, Users
#                          HSG: HSG-06-30-11
#                         .Link
#                           Http://www.ScriptingGuys.com/blog
#                       #Requires -Version 2.0
#                       #>
#[CmdletBinding()]
#Param (
#	[Parameter(Position = 0,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$userName,
#	[Parameter(Position = 1,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$password,
#	[string]$computerName = $env:ComputerName,
#	[string]$description = "Created by PowerShell"
#)
#$computer = [ADSI]"WinNT://$computerName"
#$user = $computer.Create("User", $userName)
#$user.setpassword($password)
#$user.put("description", $description)
#$user.SetInfo()
#
#CmdletBinding       : True
#DefaultParameterSet :
#Definition          :
#                        <#
#                         .Synopsis
#                          This function creates a local user
#                         .Description
#                          This function creates a local user
#                         .Example
#                          New-LocalUser -userName "ed" -description "cool Scripting Guy" `
#                              -password "password"
#                          Creates a new local user named ed with a description of cool scripting guy
#                          and a password of password.
#                         .Parameter ComputerName
#                          The name of the computer upon which to create the user
#                         .Parameter UserName
#                          The name of the user to create
#                         .Parameter password
#                          The password for the newly created user
#                         .Parameter description
#                          The description for the newly created user
#                         .Notes
#                          NAME:  New-LocalUser
#                          AUTHOR: ed wilson, msft
#                          LASTEDIT: 06/29/2011 10:07:42
#                          KEYWORDS: Local Account Management, Users
#                          HSG: HSG-06-30-11
#                         .Link
#                           Http://www.ScriptingGuys.com/blog
#                       #Requires -Version 2.0
#                       #>
#[CmdletBinding()]
#Param (
#	[Parameter(Position = 0,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$userName,
#	[Parameter(Position = 1,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$password,
#	[string]$computerName = $env:ComputerName,
#	[string]$description = "Created by PowerShell"
#)
#$computer = [ADSI]"WinNT://$computerName"
#$user = $computer.Create("User", $userName)
#$user.setpassword($password)
#$user.put("description", $description)
#$user.SetInfo()
#
#Options             : None
#Description         :
#Verb                : New
#Noun                : LocalUser
#HelpFile            :
#OutputType          : { }
#Name                : New-LocalUser
#CommandType         : Function
#Source              : localusermanagement
#Version             : 3.0
#Visibility          : Public
#ModuleName          : localusermanagement
#Module              : localusermanagement
#RemotingCapability  : SupportedByCommand
#Parameters          : {
#	[userName, System.Management.Automation.ParameterMetadata], [password, System.Management.Automation.ParameterMetadata], [computerName,
#	System.Management.Automation.ParameterMetadata], [description, System.Management.Automation.ParameterMetadata]...
#}
#ParameterSets       : { [- userName] <string> [-password] <string> [-computerName <string>] [-description <string>] [<CommonParameters>] }
#HelpUri             : Http://www.ScriptingGuys.com/blog
##Requires
#
#
#ScriptBlock         :
#                       <#
#                         .Synopsis
#                          This function deletes a local group
#                         .Description
#                          This function deletes a local group
#                         .Example
#                          Remove-LocalGroup -GroupName "mygroup"
#                          Creates a new local group named mygroup.
#                         .Parameter ComputerName
#                          The name of the computer upon which to delete the group
#                         .Parameter GroupName
#                          The name of the Group to delete
#                         .Notes
#                          NAME:  Remove-LocalGroup
#                          AUTHOR: ed wilson, msft
#                          LASTEDIT: 06/29/2011 10:07:42
#                          KEYWORDS: Local Account Management, Groups
#                          HSG: HSG-06-30-11
#                         .Link
#                           Http://www.ScriptingGuys.com/blog
#                       #Requires -Version 2.0
#                       #>
#[CmdletBinding()]
#Param (
#	[Parameter(Position = 0,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$GroupName,
#	[string]$computerName = $env:ComputerName
#)
#$Group = [ADSI]"WinNT://$computerName"
#$Group.Delete("Group", $GroupName)
#
#CmdletBinding       : True
#DefaultParameterSet :
#Definition          :
#                       <#
#                         .Synopsis
#                          This function deletes a local group
#                         .Description
#                          This function deletes a local group
#                         .Example
#                          Remove-LocalGroup -GroupName "mygroup"
#                          Creates a new local group named mygroup.
#                         .Parameter ComputerName
#                          The name of the computer upon which to delete the group
#                         .Parameter GroupName
#                          The name of the Group to delete
#                         .Notes
#                          NAME:  Remove-LocalGroup
#                          AUTHOR: ed wilson, msft
#                          LASTEDIT: 06/29/2011 10:07:42
#                          KEYWORDS: Local Account Management, Groups
#                          HSG: HSG-06-30-11
#                         .Link
#                           Http://www.ScriptingGuys.com/blog
#                       #Requires -Version 2.0
#                       #>
#[CmdletBinding()]
#Param (
#	[Parameter(Position = 0,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$GroupName,
#	[string]$computerName = $env:ComputerName
#)
#$Group = [ADSI]"WinNT://$computerName"
#$Group.Delete("Group", $GroupName)
#
#Options             : None
#Description         :
#Verb                : Remove
#Noun                : LocalGroup
#HelpFile            :
#OutputType          : { }
#Name                : Remove-LocalGroup
#CommandType         : Function
#Source              : localusermanagement
#Version             : 3.0
#Visibility          : Public
#ModuleName          : localusermanagement
#Module              : localusermanagement
#RemotingCapability  : SupportedByCommand
#Parameters          : {
#	[GroupName, System.Management.Automation.ParameterMetadata], [computerName, System.Management.Automation.ParameterMetadata],
#	[ErrorAction, System.Management.Automation.ParameterMetadata], [WarningAction, System.Management.Automation.ParameterMetadata]...
#}
#ParameterSets       : { [- GroupName] <string> [-computerName <string>] [<CommonParameters>] }
#HelpUri             : Http://www.ScriptingGuys.com/blog
##Requires
#
#
#ScriptBlock         :
#                       <#
#                         .Synopsis
#                          This function deletes a local user
#                         .Description
#                          This function deletes a local user
#                         .Example
#                          Remove-LocalUser -userName "ed"
#                          Removes a new local user named ed.
#                         .Parameter ComputerName
#                          The name of the computer upon which to delete the user
#                         .Parameter UserName
#                          The name of the user to delete
#                         .Notes
#                          NAME:  Remove-LocalUser
#                          AUTHOR: ed wilson, msft
#                          LASTEDIT: 06/29/2011 10:07:42
#                          KEYWORDS: Local Account Management, Users
#                          HSG: HSG-06-30-11
#                         .Link
#                           Http://www.ScriptingGuys.com/blog
#                       #Requires -Version 2.0
#                       #>
#[CmdletBinding()]
#Param (
#	[Parameter(Position = 0,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$userName,
#	[string]$computerName = $env:ComputerName
#)
#$User = [ADSI]"WinNT://$computerName"
#$user.Delete("User", $userName)
#
#CmdletBinding       : True
#DefaultParameterSet :
#Definition          :
#                       <#
#                         .Synopsis
#                          This function deletes a local user
#                         .Description
#                          This function deletes a local user
#                         .Example
#                          Remove-LocalUser -userName "ed"
#                          Removes a new local user named ed.
#                         .Parameter ComputerName
#                          The name of the computer upon which to delete the user
#                         .Parameter UserName
#                          The name of the user to delete
#                         .Notes
#                          NAME:  Remove-LocalUser
#                          AUTHOR: ed wilson, msft
#                          LASTEDIT: 06/29/2011 10:07:42
#                          KEYWORDS: Local Account Management, Users
#                          HSG: HSG-06-30-11
#                         .Link
#                           Http://www.ScriptingGuys.com/blog
#                       #Requires -Version 2.0
#                       #>
#[CmdletBinding()]
#Param (
#	[Parameter(Position = 0,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$userName,
#	[string]$computerName = $env:ComputerName
#)
#$User = [ADSI]"WinNT://$computerName"
#$user.Delete("User", $userName)
#
#Options             : None
#Description         :
#Verb                : Remove
#Noun                : LocalUser
#HelpFile            :
#OutputType          : { }
#Name                : Remove-LocalUser
#CommandType         : Function
#Source              : localusermanagement
#Version             : 3.0
#Visibility          : Public
#ModuleName          : localusermanagement
#Module              : localusermanagement
#RemotingCapability  : SupportedByCommand
#Parameters          : {
#	[userName, System.Management.Automation.ParameterMetadata], [computerName, System.Management.Automation.ParameterMetadata],
#	[ErrorAction, System.Management.Automation.ParameterMetadata], [WarningAction, System.Management.Automation.ParameterMetadata]...
#}
#ParameterSets       : { [- userName] <string> [-computerName <string>] [<CommonParameters>] }
#HelpUri             : Http://www.ScriptingGuys.com/blog
##Requires
#
#
#ScriptBlock         :
#                        <#
#                         .Synopsis
#                          This function adds or removes a local user to a local group
#                         .Description
#                          This function adds or removes a local user to a local group
#                         .Example
#                          Set-LocalGroup -username "ed" -groupname "administrators" -add
#                          Assigns the local user ed to the local administrators group
#                         .Example
#                          Set-LocalGroup -username "ed" -groupname "administrators" -remove
#                          Removes the local user ed to the local administrators group
#                         .Parameter username
#                          The name of the local user
#                         .Parameter groupname
#                          The name of the local group
#                         .Parameter ComputerName
#                          The name of the computer
#                         .Parameter add
#                          causes function to add the user
#                         .Parameter remove
#                          causes the function to remove the user
#                         .Notes
#                          NAME:  Set-LocalGroup
#                          AUTHOR: ed wilson, msft
#                          LASTEDIT: 06/29/2011 10:23:53
#                          KEYWORDS: Local Account Management, Users, Groups
#                          HSG: HSG-06-30-11
#                         .Link
#                           Http://www.ScriptingGuys.com/blog
#                       #Requires -Version 2.0
#                       #>
#[CmdletBinding()]
#Param (
#	[Parameter(Position = 0,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$userName,
#	[Parameter(Position = 1,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$GroupName,
#	[string]$computerName = $env:ComputerName,
#	[Parameter(ParameterSetName = 'addUser')]
#	[switch]$add,
#	[Parameter(ParameterSetName = 'removeuser')]
#	[switch]$remove
#)
#$group = [ADSI]"WinNT://$ComputerName/$GroupName,group"
#if ($add)
#{
#	$group.add("WinNT://$ComputerName/$UserName")
#}
#if ($remove)
#{
#	$group.remove("WinNT://$ComputerName/$UserName")
#}
#
#CmdletBinding       : True
#DefaultParameterSet :
#Definition          :
#                        <#
#                         .Synopsis
#                          This function adds or removes a local user to a local group
#                         .Description
#                          This function adds or removes a local user to a local group
#                         .Example
#                          Set-LocalGroup -username "ed" -groupname "administrators" -add
#                          Assigns the local user ed to the local administrators group
#                         .Example
#                          Set-LocalGroup -username "ed" -groupname "administrators" -remove
#                          Removes the local user ed to the local administrators group
#                         .Parameter username
#                          The name of the local user
#                         .Parameter groupname
#                          The name of the local group
#                         .Parameter ComputerName
#                          The name of the computer
#                         .Parameter add
#                          causes function to add the user
#                         .Parameter remove
#                          causes the function to remove the user
#                         .Notes
#                          NAME:  Set-LocalGroup
#                          AUTHOR: ed wilson, msft
#                          LASTEDIT: 06/29/2011 10:23:53
#                          KEYWORDS: Local Account Management, Users, Groups
#                          HSG: HSG-06-30-11
#                         .Link
#                           Http://www.ScriptingGuys.com/blog
#                       #Requires -Version 2.0
#                       #>
#[CmdletBinding()]
#Param (
#	[Parameter(Position = 0,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$userName,
#	[Parameter(Position = 1,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$GroupName,
#	[string]$computerName = $env:ComputerName,
#	[Parameter(ParameterSetName = 'addUser')]
#	[switch]$add,
#	[Parameter(ParameterSetName = 'removeuser')]
#	[switch]$remove
#)
#$group = [ADSI]"WinNT://$ComputerName/$GroupName,group"
#if ($add)
#{
#	$group.add("WinNT://$ComputerName/$UserName")
#}
#if ($remove)
#{
#	$group.remove("WinNT://$ComputerName/$UserName")
#}
#
#Options             : None
#Description         :
#Verb                : Set
#Noun                : LocalGroup
#HelpFile            :
#OutputType          : { }
#Name                : Set-LocalGroup
#CommandType         : Function
#Source              : localusermanagement
#Version             : 3.0
#Visibility          : Public
#ModuleName          : localusermanagement
#Module              : localusermanagement
#RemotingCapability  : SupportedByCommand
#Parameters          : {
#	[userName, System.Management.Automation.ParameterMetadata], [GroupName, System.Management.Automation.ParameterMetadata], [computerName,
#	System.Management.Automation.ParameterMetadata], [add, System.Management.Automation.ParameterMetadata]...
#}
#ParameterSets       : {
#	[- userName] <string> [-GroupName] <string> [-computerName <string>] [-add] [<CommonParameters>], [-userName] <string> [-GroupName]
#	<string> [-computerName <string>] [-remove] [<CommonParameters>]
#}
#HelpUri             : Http://www.ScriptingGuys.com/blog
##Requires
#
#
#ScriptBlock         :
#                        <#
#                         .Synopsis
#                          Enables or disables a local user
#                         .Description
#                          This function enables or disables a local user
#                         .Example
#                          Set-LocalUser -userName ed -disable
#                          Disables a local user account named ed
#                         .Example
#                          Set-LocalUser -userName ed -password Password
#                          Enables a local user account named ed and gives it the password password
#                         .Parameter UserName
#                          The name of the user to either enable or disable
#                         .Parameter Password
#                          The password of the user once it is enabled
#                         .Parameter Description
#                          A description to associate with the user account
#                         .Parameter Enable
#                          Enables the user account
#                         .Parameter Disable
#                          Disables the user account
#                         .Parameter ComputerName
#                          The name of the computer on which to perform the action
#                         .Notes
#                          NAME:  Set-LocalUser
#                          AUTHOR: ed wilson, msft
#                          LASTEDIT: 06/29/2011 12:40:43
#                          KEYWORDS: Local Account Management, Users
#                          HSG: HSG-6-30-2011
#                         .Link
#                           Http://www.ScriptingGuys.com/blog
#                       #Requires -Version 2.0
#                       #>
#[CmdletBinding()]
#Param (
#	[Parameter(Position = 0,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$userName,
#	[Parameter(Position = 1,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True,
#			   ParameterSetName = 'EnableUser')]
#	[string]$password,
#	[Parameter(ParameterSetName = 'EnableUser')]
#	[switch]$enable,
#	[Parameter(ParameterSetName = 'DisableUser')]
#	[switch]$disable,
#	[string]$computerName = $env:ComputerName,
#	[string]$description = "modified via powershell"
#)
#$EnableUser = 512 # ADS_USER_FLAG_ENUM enumeration value from SDK
#$DisableUser = 2 # ADS_USER_FLAG_ENUM enumeration value from SDK
#$User = [ADSI]"WinNT://$computerName/$userName,User"
#
#if ($enable)
#{
#	$User.setpassword($password)
#	$User.description = $description
#	$User.userflags = $EnableUser
#	$User.setinfo()
#} #end if enable
#if ($disable)
#{
#	$User.description = $description
#	$User.userflags = $DisableUser
#	$User.setinfo()
#} #end if disable
#
#CmdletBinding       : True
#DefaultParameterSet :
#Definition          :
#                        <#
#                         .Synopsis
#                          Enables or disables a local user
#                         .Description
#                          This function enables or disables a local user
#                         .Example
#                          Set-LocalUser -userName ed -disable
#                          Disables a local user account named ed
#                         .Example
#                          Set-LocalUser -userName ed -password Password
#                          Enables a local user account named ed and gives it the password password
#                         .Parameter UserName
#                          The name of the user to either enable or disable
#                         .Parameter Password
#                          The password of the user once it is enabled
#                         .Parameter Description
#                          A description to associate with the user account
#                         .Parameter Enable
#                          Enables the user account
#                         .Parameter Disable
#                          Disables the user account
#                         .Parameter ComputerName
#                          The name of the computer on which to perform the action
#                         .Notes
#                          NAME:  Set-LocalUser
#                          AUTHOR: ed wilson, msft
#                          LASTEDIT: 06/29/2011 12:40:43
#                          KEYWORDS: Local Account Management, Users
#                          HSG: HSG-6-30-2011
#                         .Link
#                           Http://www.ScriptingGuys.com/blog
#                       #Requires -Version 2.0
#                       #>
#[CmdletBinding()]
#Param (
#	[Parameter(Position = 0,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$userName,
#	[Parameter(Position = 1,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True,
#			   ParameterSetName = 'EnableUser')]
#	[string]$password,
#	[Parameter(ParameterSetName = 'EnableUser')]
#	[switch]$enable,
#	[Parameter(ParameterSetName = 'DisableUser')]
#	[switch]$disable,
#	[string]$computerName = $env:ComputerName,
#	[string]$description = "modified via powershell"
#)
#$EnableUser = 512 # ADS_USER_FLAG_ENUM enumeration value from SDK
#$DisableUser = 2 # ADS_USER_FLAG_ENUM enumeration value from SDK
#$User = [ADSI]"WinNT://$computerName/$userName,User"
#
#if ($enable)
#{
#	$User.setpassword($password)
#	$User.description = $description
#	$User.userflags = $EnableUser
#	$User.setinfo()
#} #end if enable
#if ($disable)
#{
#	$User.description = $description
#	$User.userflags = $DisableUser
#	$User.setinfo()
#} #end if disable
#
#Options             : None
#Description         :
#Verb                : Set
#Noun                : LocalUser
#HelpFile            :
#OutputType          : { }
#Name                : Set-LocalUser
#CommandType         : Function
#Source              : localusermanagement
#Version             : 3.0
#Visibility          : Public
#ModuleName          : localusermanagement
#Module              : localusermanagement
#RemotingCapability  : SupportedByCommand
#Parameters          : {
#	[userName, System.Management.Automation.ParameterMetadata], [password, System.Management.Automation.ParameterMetadata], [enable,
#	System.Management.Automation.ParameterMetadata], [disable, System.Management.Automation.ParameterMetadata]...
#}
#ParameterSets       : {
#	[- userName] <string> [-password] <string> [-enable] [-computerName <string>] [-description <string>] [<CommonParameters>], [-userName]
#	<string> [-disable] [-computerName <string>] [-description <string>] [<CommonParameters>]
#}
#HelpUri             : Http://www.ScriptingGuys.com/blog
##Requires
#
#
#ScriptBlock         :
#                       <#
#                         .Synopsis
#                          This function changes a local user password
#                         .Description
#                          This function changes a local user password
#                         .Example
#                          Set-LocalUserPassword -userName "ed" -password "newpassword"
#                          Changes a local user named ed password to newpassword.
#                         .Parameter ComputerName
#                          The name of the computer upon which to change the user's password
#                         .Parameter UserName
#                          The name of the user for which to change the password
#                         .Parameter password
#                          The new password for the user
#                         .Notes
#                          NAME:  Set-LocalUserPassword
#                          AUTHOR: ed wilson, msft
#                          LASTEDIT: 06/29/2011 10:07:42
#                          KEYWORDS: Local Account Management, Users
#                          HSG: HSG-06-30-11
#                         .Link
#                           Http://www.ScriptingGuys.com/blog
#                       #Requires -Version 2.0
#                       #>
#[CmdletBinding()]
#Param (
#	[Parameter(Position = 0,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$userName,
#	[Parameter(Position = 1,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$password,
#	[string]$computerName = $env:ComputerName
#)
#$user = [ADSI]"WinNT://$computerName/$username,user"
#$user.setpassword($password)
#$user.SetInfo()
#
#CmdletBinding       : True
#DefaultParameterSet :
#Definition          :
#                       <#
#                         .Synopsis
#                          This function changes a local user password
#                         .Description
#                          This function changes a local user password
#                         .Example
#                          Set-LocalUserPassword -userName "ed" -password "newpassword"
#                          Changes a local user named ed password to newpassword.
#                         .Parameter ComputerName
#                          The name of the computer upon which to change the user's password
#                         .Parameter UserName
#                          The name of the user for which to change the password
#                         .Parameter password
#                          The new password for the user
#                         .Notes
#                          NAME:  Set-LocalUserPassword
#                          AUTHOR: ed wilson, msft
#                          LASTEDIT: 06/29/2011 10:07:42
#                          KEYWORDS: Local Account Management, Users
#                          HSG: HSG-06-30-11
#                         .Link
#                           Http://www.ScriptingGuys.com/blog
#                       #Requires -Version 2.0
#                       #>
#[CmdletBinding()]
#Param (
#	[Parameter(Position = 0,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$userName,
#	[Parameter(Position = 1,
#			   Mandatory = $True,
#			   ValueFromPipeline = $True)]
#	[string]$password,
#	[string]$computerName = $env:ComputerName
#)
#$user = [ADSI]"WinNT://$computerName/$username,user"
#$user.setpassword($password)
#$user.SetInfo()
#
#Options             : None
#Description         :
#Verb                : Set
#Noun                : LocalUserPassword
#HelpFile            :
#OutputType          : { }
#Name                : Set-LocalUserPassword
#CommandType         : Function
#Source              : localusermanagement
#Version             : 3.0
#Visibility          : Public
#ModuleName          : localusermanagement
#Module              : localusermanagement
#RemotingCapability  : SupportedByCommand
#Parameters          : {
#	[userName, System.Management.Automation.ParameterMetadata], [password, System.Management.Automation.ParameterMetadata], [computerName,
#	System.Management.Automation.ParameterMetadata], [ErrorAction, System.Management.Automation.ParameterMetadata]...
#}
#ParameterSets       : { [- userName] <string> [-password] <string> [-computerName <string>] [<CommonParameters>] }
#HelpUri             : Http://www.ScriptingGuys.com/blog
##Requires
#
#
#ScriptBlock         :
#                          <#
#                          .Synopsis
#                              Tests if the user is an administrator
#                          .Description
#                              Returns true if a user is an administrator, false if the user is not an administrator
#                          .Example
#                              Test-IsAdministrator
#                          #>
#param ()
#$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
#(New-Object Security.Principal.WindowsPrincipal $currentUser).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
#
#CmdletBinding       : False
#DefaultParameterSet :
#Definition          :
#                          <#
#                          .Synopsis
#                              Tests if the user is an administrator
#                          .Description
#                              Returns true if a user is an administrator, false if the user is not an administrator
#                          .Example
#                              Test-IsAdministrator
#                          #>
#param ()
#$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
#(New-Object Security.Principal.WindowsPrincipal $currentUser).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
#
#Options             : None
#Description         :
#Verb                : Test
#Noun                : IsAdministrator
#HelpFile            :
#OutputType          : { }
#Name                : Test-IsAdministrator
#CommandType         : Function
#Source              : localusermanagement
#Version             : 3.0
#Visibility          : Public
#ModuleName          : localusermanagement
#Module              : localusermanagement
#RemotingCapability  : PowerShell
#Parameters          : { }
#ParameterSets       : { }
#HelpUri             :
#
#False
#
#
#
#>> Execution time: 00:01:45
#>> Script Ended

#---------------------------------------
# me: returns true in PS v5 64-bits console
#Windows PowerShell
#Copyright (C) 2015 Microsoft Corporation. All rights reserved.
#
#PSVERSION: 5.0.10586.117
#PS C:\> Test-IsAdministrator
#True
#PS C:\>

#-------------------------
#me: returns False in STA
#>> Running (Test-DrivingPowerShellGet.ps1) Script Selection...
#>> Platform: V5 64Bit (STA)
#False
#
#>> Execution time: 00:00:01
#>> Script Ended
