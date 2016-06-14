<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	6/14/2016 4:36 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#Minimizing All Application Windows
#
#In a previous tip we explained how PowerShell can access low level API functions such as ShowWindowAsync(). Once you better understand how a particular API function works you can use it for many purposes. Here is an example that takes all open application windows and hides them:

# create a new .NET type 
$signature = @"
[DllImport("user32.dll")]public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
"@
Add-Type -MemberDefinition $signature -Name MyType -Namespace MyNamespace

Get-Process |
Where-Object { $_.MainWindowHandle } |
ForEach-Object {
	$handle = $_.MainWindowHandle
	
	# minimize window
	$null = [MyNamespace.MyType]::ShowWindowAsync($handle, 2)
}

#Surprisingly, this will not minimize all windows. Explorer windows stay open. This is because Explorer windows are child windows of a hidden master Explorer.

# me: this also leaves residual grey windows... ...this might mean we need to dispose of the instanciated "user32.dll"

