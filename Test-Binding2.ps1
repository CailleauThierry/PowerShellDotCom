<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	7/16/2016 6:48 AM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#requires -Version 2
#Type-Based Parameter Binding (Part 2)
#PowerShell 2+
#
#In a previous tip we introduced automatic type-based parameter binding. Here is a use case. The function Test-Binding accepts files and folders. For incoming files, it calculates the file size. For incoming folders, it emits a warning. Note how the parameter binding works per incoming element:

function Test-Binding
{
	#Content
	param
	(
		[System.IO.FileInfo][Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'File', Position = 0)]
		$File,
		[System.IO.DirectoryInfo][Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Folder', Position = 0)]
		$Folder,
		[Parameter(ParameterSetName = 'File', ValueFromPipelineByPropertyName = $true)]
		$Length
	)
	
	process
	{
		
		if ($PSCmdlet.ParameterSetName -eq 'File')
		{
			'File Size: {0:n1} MB' -f ($Length/1MB)
		}
		else
		{
			Write-Warning "Folder ignored: $Folder"
		}
	}
}


Get-ChildItem c:\windows | Test-Binding -Verbose

#>> Running (Test-Binding2.ps1) Script...
#>> Platform: V2 64Bit (STA)
#ERROR:, : The "=" operator is missing after a named argument.
#ERROR:     + CategoryInfo          : ParserError: (:) [], ParseException
#ERROR:     + FullyQualifiedErrorId : MissingEqualsInNamedArgument
#ERROR:
#
#>> Execution time: < 1 second
#>> Script Ended
#----after adding '= $true' for each unassigned parameters properties------------------------------------
#>> Running (Test-Binding2.ps1) Script...
#>> Platform: V2 64Bit (STA)
#WARNING: Folder ignored: addins
#WARNING: Folder ignored: ADFS
#WARNING: Folder ignored: AppCompat
#WARNING: Folder ignored: apppatch
#WARNING: Folder ignored: AppReadiness
#WARNING: Folder ignored: assembly
#WARNING: Folder ignored: Boot
#WARNING: Folder ignored: Branding
#WARNING: Folder ignored: Camera
#WARNING: Folder ignored: CbsTemp
#WARNING: Folder ignored: CSC
#WARNING: Folder ignored: Cursors
#WARNING: Folder ignored: debug
#WARNING: Folder ignored: DesktopTileResources
#WARNING: Folder ignored: diagnostics
#WARNING: Folder ignored: DigitalLocker
#WARNING: Folder ignored: Downloaded Program Files
#WARNING: Folder ignored: en-US
#WARNING: Folder ignored: FileManager
#WARNING: Folder ignored: Fonts
#WARNING: Folder ignored: Globalization
#WARNING: Folder ignored: Help
#WARNING: Folder ignored: IME
#WARNING: Folder ignored: ImmersiveControlPanel
#WARNING: Folder ignored: Inf
#WARNING: Folder ignored: InputMethod
#WARNING: Folder ignored: L2Schemas
#WARNING: Folder ignored: LiveKernelReports
#WARNING: Folder ignored: Logs
#WARNING: Folder ignored: Media
#WARNING: Folder ignored: MediaViewer
#WARNING: Folder ignored: Microsoft.NET
#WARNING: Folder ignored: Migration
#WARNING: Folder ignored: ModemLogs
#WARNING: Folder ignored: Offline Web Pages
#WARNING: Folder ignored: Panther
#WARNING: Folder ignored: PCHEALTH
#WARNING: Folder ignored: Performance
#WARNING: Folder ignored: PLA
#WARNING: Folder ignored: PolicyDefinitions
#WARNING: Folder ignored: Prefetch
#WARNING: Folder ignored: Registration
#WARNING: Folder ignored: RemotePackages
#WARNING: Folder ignored: rescache
#WARNING: Folder ignored: Resources
#WARNING: Folder ignored: SchCache
#WARNING: Folder ignored: schemas
#WARNING: Folder ignored: security
#WARNING: Folder ignored: ServiceProfiles
#WARNING: Folder ignored: servicing
#WARNING: Folder ignored: Setup
#WARNING: Folder ignored: ShellNew
#WARNING: Folder ignored: SKB
#WARNING: Folder ignored: SoftwareDistribution
#WARNING: Folder ignored: Speech
#WARNING: Folder ignored: System
#WARNING: Folder ignored: System32
#WARNING: Folder ignored: SystemResources
#WARNING: Folder ignored: SysWOW64
#WARNING: Folder ignored: TAPI
#WARNING: Folder ignored: Tasks
#WARNING: Folder ignored: Temp
#WARNING: Folder ignored: ToastData
#WARNING: Folder ignored: tracing
#WARNING: Folder ignored: twain_32
#WARNING: Folder ignored: vpnplugins
#WARNING: Folder ignored: Vss
#WARNING: Folder ignored: Web
#WARNING: Folder ignored: WinStore
#WARNING: Folder ignored: WinSxS
#WARNING: Folder ignored: wlansvc
#File Size: 0.0 MB
#File Size: 0.1 MB
#File Size: 0.1 MB
#File Size: 0.0 MB
#File Size: 0.0 MB
#File Size: 0.6 MB
#File Size: 0.0 MB
#File Size: 2.6 MB
#File Size: 1.0 MB
#File Size: 0.0 MB
#File Size: 0.3 MB
#File Size: 0.0 MB
#File Size: 0.2 MB
#File Size: 0.0 MB
#File Size: 0.1 MB
#File Size: 0.0 MB
#File Size: 0.0 MB
#File Size: 0.0 MB
#File Size: 0.1 MB
#File Size: 0.0 MB
#File Size: 0.0 MB
#File Size: 0.1 MB
#File Size: 0.0 MB
#File Size: 0.0 MB
#File Size: 1.1 MB
#File Size: 0.0 MB
#File Size: 0.3 MB
#File Size: 0.0 MB
#
#>> Execution time: < 1 second
#>> Script Ended
#-----------------------------
#>> Running (Test-Binding2.ps1) Script...
#>> Platform: V5 64Bit (STA)
#WARNING: Folder ignored: addins
#WARNING: Folder ignored: ADFS
#WARNING: Folder ignored: AppCompat
#WARNING: Folder ignored: apppatch
#WARNING: Folder ignored: AppReadiness
#WARNING: Folder ignored: assembly
#WARNING: Folder ignored: Boot
#WARNING: Folder ignored: Branding
#WARNING: Folder ignored: Camera
#WARNING: Folder ignored: CbsTemp
#WARNING: Folder ignored: CSC
#WARNING: Folder ignored: Cursors
#WARNING: Folder ignored: debug
#WARNING: Folder ignored: DesktopTileResources
#WARNING: Folder ignored: diagnostics
#WARNING: Folder ignored: DigitalLocker
#WARNING: Folder ignored: Downloaded Program Files
#WARNING: Folder ignored: en-US
#WARNING: Folder ignored: FileManager
#WARNING: Folder ignored: Fonts
#WARNING: Folder ignored: Globalization
#WARNING: Folder ignored: Help
#WARNING: Folder ignored: IME
#WARNING: Folder ignored: ImmersiveControlPanel
#WARNING: Folder ignored: Inf
#WARNING: Folder ignored: InputMethod
#WARNING: Folder ignored: L2Schemas
#WARNING: Folder ignored: LiveKernelReports
#WARNING: Folder ignored: Logs
#WARNING: Folder ignored: Media
#WARNING: Folder ignored: MediaViewer
#WARNING: Folder ignored: Microsoft.NET
#WARNING: Folder ignored: Migration
#WARNING: Folder ignored: ModemLogs
#WARNING: Folder ignored: Offline Web Pages
#WARNING: Folder ignored: Panther
#WARNING: Folder ignored: PCHEALTH
#WARNING: Folder ignored: Performance
#WARNING: Folder ignored: PLA
#WARNING: Folder ignored: PolicyDefinitions
#WARNING: Folder ignored: Prefetch
#WARNING: Folder ignored: Registration
#WARNING: Folder ignored: RemotePackages
#WARNING: Folder ignored: rescache
#WARNING: Folder ignored: Resources
#WARNING: Folder ignored: SchCache
#WARNING: Folder ignored: schemas
#WARNING: Folder ignored: security
#WARNING: Folder ignored: ServiceProfiles
#WARNING: Folder ignored: servicing
#WARNING: Folder ignored: Setup
#WARNING: Folder ignored: ShellNew
#WARNING: Folder ignored: SKB
#WARNING: Folder ignored: SoftwareDistribution
#WARNING: Folder ignored: Speech
#WARNING: Folder ignored: System
#WARNING: Folder ignored: System32
#WARNING: Folder ignored: SystemResources
#WARNING: Folder ignored: SysWOW64
#WARNING: Folder ignored: TAPI
#WARNING: Folder ignored: Tasks
#WARNING: Folder ignored: Temp
#WARNING: Folder ignored: ToastData
#WARNING: Folder ignored: tracing
#WARNING: Folder ignored: twain_32
#WARNING: Folder ignored: vpnplugins
#WARNING: Folder ignored: Vss
#WARNING: Folder ignored: Web
#WARNING: Folder ignored: WinStore
#WARNING: Folder ignored: WinSxS
#WARNING: Folder ignored: wlansvc
#File Size: 0.0 MB
#File Size: 0.1 MB
#File Size: 0.1 MB
#File Size: 0.0 MB
#File Size: 0.0 MB
#File Size: 0.6 MB
#File Size: 0.0 MB
#File Size: 2.6 MB
#File Size: 1.0 MB
#File Size: 0.0 MB
#File Size: 0.3 MB
#File Size: 0.0 MB
#File Size: 0.2 MB
#File Size: 0.0 MB
#File Size: 0.1 MB
#File Size: 0.0 MB
#File Size: 0.0 MB
#File Size: 0.0 MB
#File Size: 0.1 MB
#File Size: 0.0 MB
#File Size: 0.0 MB
#File Size: 0.1 MB
#File Size: 0.0 MB
#File Size: 0.0 MB
#File Size: 1.1 MB
#File Size: 0.0 MB
#File Size: 0.3 MB
#File Size: 0.0 MB
#
#>> Execution time: 00:00:01
#>> Script Ended
