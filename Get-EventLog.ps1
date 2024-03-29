<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	10_25_2021 10:48 AM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	Get-EventLog.ps1
	===========================================================================
	.DESCRIPTION
Working with Get-WinEvent

If you'd like to read system events from the Windows event log, Get-EventLog is simple to use and straightforward. This gets you the latest 10 error and warning events:
PS> Get-EventLog -LogName System -EntryType Error,Warning -Newest 10  
Unfortunately, Get-EventLog has been deprecated, and it is not available in PowerShell 7 anymore. And there are good reasons why: the cmdlet can only read from "classic" log files, it's slow and has other limitations. 
That's why PowerShell introduced a better replacement in version 3.0: Get-WinEvent. This cmdlet is also available in PowerShell 7. 
Unfortunately, Get-WinEvent is much harder to use because there are no intuitive parameters, and instead your filter criteria needs to be specified as a hash table.
However, with a "proxy function" you can teach Get-WinEvent the old-fashioned parameters you might have gotten used to. Here it is:

#>

<#
Once you run this function, you can now use Get-WinEvent with the same parameters you used to use with Get-EventLog:
PS> Get-WinEvent -LogName System -EntryType Error,Warning -Newest 10
 
Name                           Value
----                           -----
LogName                        {System}
Level                          {1, 2, 3} 
You also get the keys and values of the hash table filter that were used based on your parameters.

#>
 
function Get-WinEvent
{
    [CmdletBinding(DefaultParameterSetName='GetLogSet', HelpUri= 'https://go.microsoft.com/fwlink/?LinkID=138336')]
    param(
        
        [Parameter(ParameterSetName='ListLogSet', Mandatory= $true, Position=0)]
        [AllowEmptyCollection()]
        [string[]]
        ${ListLog},
 
        [Parameter(ParameterSetName='LogNameGetEventlog', Mandatory= $true, Position=0)] <#NEW#> 
        [Parameter(ParameterSetName='GetLogSet', Position= 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true) ]
        [string[]]
        ${LogName},
 
        [Parameter(ParameterSetName='ListProviderSet', Mandatory= $true, Position=0)]
        [AllowEmptyCollection()]
        [string[]]
        ${ListProvider},
 
        <# Get-EventLog supports wildcards, Get-WinEvent does not. Needs to be corrected. #>
        [Parameter(ParameterSetName='GetProviderSet', Mandatory= $true, Position=0, ValueFromPipelineByPropertyName=$true) ]
        [string[]]
        ${ProviderName},
 
        [Parameter(ParameterSetName='FileSet', Mandatory= $true, Position=0, ValueFromPipelineByPropertyName=$true) ]
        [Alias('PSPath')]
        [string[]]
        ${Path},
 
        [Parameter(ParameterSetName='FileSet')]
        [Parameter(ParameterSetName='GetProviderSet')]
        [Parameter(ParameterSetName='GetLogSet')]
        [Parameter(ParameterSetName='HashQuerySet')]
        [Parameter(ParameterSetName='XmlQuerySet')]
        [ValidateRange(1, 9223372036854775807) ]
        [long]
        ${MaxEvents},
        
        <# NEW #>
        [Parameter(ParameterSetName='LogNameGetEventlog')]
        [ValidateRange(0, 2147483647) ]
        [int]
        ${Newest},
        
        [Parameter(ParameterSetName='GetProviderSet')]
        [Parameter(ParameterSetName='ListProviderSet')]
        [Parameter(ParameterSetName='ListLogSet')]
        [Parameter(ParameterSetName='GetLogSet')]
        [Parameter(ParameterSetName='HashQuerySet')]
        [Parameter(ParameterSetName='XmlQuerySet')]
        [Parameter(ParameterSetName='LogNameGetEventlog')] <#NEW#> 
        [Alias('Cn')]
        [ValidateNotNullOrEmpty()] <#CORRECTED#>
        [string] <# used to be [String[]], Get-WinEvent accepts [string] only, should be changed to accept string arrays #>
        ${ComputerName},
 
        [Parameter(ParameterSetName='GetProviderSet')]
        [Parameter(ParameterSetName='ListProviderSet')]
        [Parameter(ParameterSetName='ListLogSet')]
        [Parameter(ParameterSetName='GetLogSet')]
        [Parameter(ParameterSetName='HashQuerySet')]
        [Parameter(ParameterSetName='XmlQuerySet')]
        [Parameter(ParameterSetName='FileSet')]
        [pscredential]
        [System.Management.Automation.CredentialAttribute()]
        ${Credential},
 
        [Parameter(ParameterSetName='FileSet')]
        [Parameter(ParameterSetName='GetProviderSet')]
        [Parameter(ParameterSetName='GetLogSet')]
        [ValidateNotNull()]
        [string]
        ${FilterXPath},
 
        [Parameter(ParameterSetName='XmlQuerySet', Mandatory= $true, Position=0)]
        [xml]
        ${FilterXml},
 
        [Parameter(ParameterSetName='HashQuerySet', Mandatory= $true, Position=0)]
        [hashtable[]]
        ${FilterHashtable},
 
        [Parameter(ParameterSetName='GetProviderSet')]
        [Parameter(ParameterSetName='ListLogSet')]
        [Parameter(ParameterSetName='GetLogSet')]
        [Parameter(ParameterSetName='HashQuerySet')]
        [switch]
        ${Force},
 
        [Parameter(ParameterSetName='GetLogSet')]
        [Parameter(ParameterSetName='GetProviderSet')]
        [Parameter(ParameterSetName='FileSet')]
        [Parameter(ParameterSetName='HashQuerySet')]
        [Parameter(ParameterSetName='XmlQuerySet')]
        [switch]
        ${Oldest},
    
        <# NEW #>
        [Parameter(ParameterSetName='LogNameGetEventlog')]
        [ValidateNotNullOrEmpty()]
        [datetime]
        ${After},
 
        <# NEW #>
        [Parameter(ParameterSetName='LogNameGetEventlog')]
        [ValidateNotNullOrEmpty()]
        [datetime]
        ${Before},
        
        <# NEW #>
        [Parameter(ParameterSetName='LogNameGetEventlog')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        ${UserName},
 
        <# NEW #>
        [Parameter(ParameterSetName='LogNameGetEventlog', Position= 1)]
        [ValidateRange(0, 9223372036854775807) ]
        [ValidateNotNullOrEmpty()]
        [long[]]
        ${InstanceId},
 
        <# NEW #>
        [Parameter(ParameterSetName='LogNameGetEventlog')]
        [ValidateNotNullOrEmpty()]
        [ValidateRange(1, 2147483647) ]
        [int[]]
        ${Index},
 
        <# NEW #>
        [Parameter(ParameterSetName='LogNameGetEventlog')]
        [Alias('ET')]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Error','Information','FailureAudit' ,'SuccessAudit','Warning')]
        [string[]]
        ${EntryType},
 
        <# NEW #>
        [Parameter(ParameterSetName='LogNameGetEventlog')]
        [Alias('ABO')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        ${Source},
 
        <# NEW #>
        [Parameter(ParameterSetName='LogNameGetEventlog')]
        [Alias('MSG')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Message},
 
        <# NEW #>
        [Parameter(ParameterSetName='LogNameGetEventlog')]
        [switch]
        ${AsBaseObject},
        
        [Parameter(ParameterSetName='ListGetEventlog')]
        [switch]
        ${List},
 
        [Parameter(ParameterSetName='ListGetEventlog')]
        [switch]
        ${AsString}
        
        
        
    )
 
    begin
    {
        try {
            $outBuffer = $null
            if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
            {
                $PSBoundParameters['OutBuffer'] = 1
            }
            $wrappedCmd = $ExecutionContext.InvokeCommand. GetCommand('Microsoft.PowerShell.Diagnostics\Get-WinEvent', [System.Management.Automation.CommandTypes]::Cmdlet)
 
            # if the user chose the Get-EventLog compatible parameters,
            # compose the appropriate filter hash table
            $scriptCmd = if ($PSCmdlet. ParameterSetName -eq 'LogNameGetEventlog')
            {
                # mandatory parameter
                $filter = @{
                    LogName = $PSBoundParameters['Logname']
                }
                $null = $PSBoundParameters.Remove('LogName' )
                
                if ($PSBoundParameters.ContainsKey('Before'))
                {
                    $filter['EndTime'] = $PSBoundParameters['Before']
                    $null = $PSBoundParameters.Remove( 'Before')
                }
                if ($PSBoundParameters.ContainsKey('After'))
                {
                    $filter['StartTime'] = $PSBoundParameters['After']
                    $null = $PSBoundParameters.Remove( 'After')
                }
                if ($PSBoundParameters.ContainsKey('EntryType'))
                {
                    # severity is translated to an integer array
                    
                    $levelFlags = [System.Collections.Generic.List[ int]]@()
 
                    # string input converted to integer array
                    if ($PSBoundParameters['EntryType'] -contains 'Error')
                    {
                        $levelFlags.Add(1) # critical
                        $levelFlags.Add(2) # error
                    }
                    if ($PSBoundParameters['EntryType'] -contains 'Warning')
                    {
                        $levelFlags.Add(3) # warning
                    }
                    if ($PSBoundParameters['EntryType'] -contains 'Information')
                    {
                        $levelFlags.Add(4) # informational
                        $levelFlags.Add(5) # verbose
                    }
                    
                        
                    # default to 0
                    if ($levelFlags.Count -gt 0 )
                    {
                        $filter['Level'] = [int[]]$levelFlags
                    }
                        
                    # audit settings stored in Keywords key
                    if ($PSBoundParameters['EntryType'] -contains 'FailureAudit')
                    {
                        $filter['Keywords'] += 0x10000000000000
                    }
                    if ($PSBoundParameters['EntryType'] -contains 'SuccessAudit')
                    {
                        $filter['Keywords'] += 0x20000000000000
                    }
                    $null = $PSBoundParameters.Remove( 'EntryType')
                }
                if ($PSBoundParameters.ContainsKey('InstanceId'))
                {
                    $filter['ID'] = $PSBoundParameters['InstanceId']
                    $null = $PSBoundParameters.Remove( 'InstanceId')
                }
                if ($PSBoundParameters.ContainsKey('Source'))
                {
                    $filter['ProviderName'] = $PSBoundParameters['Source']
                    $null = $PSBoundParameters.Remove( 'Source')
                }
                
                $PSBoundParameters['FilterHashtable'] = $filter
                Write-Host ($filter | Out-String) -ForegroundColor Green
                
                if ($PSBoundParameters.ContainsKey('Newest'))
                {
                    $PSBoundParameters['MaxEvents'] = $PSBoundParameters['Newest']
                    $null = $PSBoundParameters.Remove( 'Newest')
                }
            }
            
            
            $scriptCmd = 
            {
                & $wrappedCmd @PSBoundParameters
            } 
            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($PSCmdlet)
        } catch {
            throw
        }
    }
 
    process
    {
        try {
            $steppablePipeline.Process($_)
        } catch {
            throw
        }
    }
 
    end
    {
        try {
            $steppablePipeline.End()
        } catch {
            throw
        }
    }
    <#
 
            .ForwardHelpTargetName Microsoft.PowerShell.Diagnostics\Get-WinEvent
            .ForwardHelpCategory Cmdlet
 
    #>
 
} 


<# 
PS> $PSVersionTable 


Name                           Value
----                           -----
PSVersion                      5.1.19041.1237
PSEdition                      Desktop
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0...}
BuildVersion                   10.0.19041.1237
CLRVersion                     4.0.30319.42000
WSManStackVersion              3.0
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1

PS> Get-WinEvent -LogName System -EntryType Error,Warning -Newest 10


Name                           Value
----                           -----
LogName                        {System}
Level                          {1, 2, 3}





   ProviderName: Microsoft-Windows-DistributedCOM

TimeCreated                      Id LevelDisplayName Message
-----------                      -- ---------------- -------
10/25/2021 10:54:46 AM        10016 Warning          The application-specific permission settings do not grant Local Activation pe... 


   ProviderName: Microsoft-Windows-DNS-Client

TimeCreated                      Id LevelDisplayName Message
-----------                      -- ---------------- -------
10/25/2021 10:52:37 AM         8015 Warning          The system failed to register host (A or AAAA) resource records (RRs) for net...
#>