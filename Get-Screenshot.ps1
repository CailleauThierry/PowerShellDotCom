<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	10_01_2021 10:50 AM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:      Get-Screenshot.ps1  	
	===========================================================================
	.DESCRIPTION
		Takes a screenshot of all the screens at once. Tested on PSVersion 5.1.19041.1023 on Windows 10 Version 10.0.19043 Build 19043
#>
<# All Versions
With types found in System.Windows.Forms, PowerShell can easily capture your screen and save the screenshot to a file. The code below captures your entire virtual screen, saves the screenshot to file, then opens the bitmap file in the associated program (if any):
#>

 
$Path = "$Env:temp\screenshot.bmp"
Add-Type -AssemblyName System.Windows.Forms

$screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
$width = $screen.Width
$height = $screen.Height
$left = $screen.Left
$top = $screen.Top
$bitmap = [System.Drawing.Bitmap]::new($width, $height)
$MyDrawing = [System.Drawing.Graphics]::FromImage($bitmap)
$MyDrawing.CopyFromScreen($left, $top, 0 , 0, $bitmap.Size)

$bitmap.Save($Path)
Start-Process -FilePath $Path