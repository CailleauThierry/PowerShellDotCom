<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	6/7/2016 4:55 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#Extracting Icons
#
#PowerShell can use C# source code to access internal Windows APIs. Here is an example that illustrates how you access icons from DLLs and EXEs and save them to disk:

# adjust these 
$DLL = "$env:windir\system32\shell32.dll"
$IconIndex = 20

$source = @'
using System;
using System.Drawing;
using System.Runtime.InteropServices;
 
public class IconExtractor
{
    
    public static Icon Extract(string file, int number, bool largeIcon)
    {
        IntPtr large;
        IntPtr small;
        ExtractIconEx(file, number, out large, out small, 1);
        try
        {
            return Icon.FromHandle(largeIcon ? large : small);
        }
        catch
        {
            return null;
        }
 
    }
    [DllImport("Shell32.dll", EntryPoint = "ExtractIconExW", CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]
    private static extern int ExtractIconEx(string sFile, int iIndex, out IntPtr piLargeVersion, out IntPtr piSmallVersion, int amountIcons);
 
}
'@

Add-Type -TypeDefinition $source -ReferencedAssemblies 'System.Drawing'
$icon = [IconExtractor]::Extract($DLL, $IconIndex, $true)
$path = "$home\Desktop\myIcon.ico"
$stream = New-Object System.IO.FileStream($path, 'Create')
$icon.Save($stream)
$stream.Dispose()

mspaint $path

#If you wanted to attach the extracted icon to a WPF window instead, use this (provided $icon contains the extracted icon and $window refers to a WPF window):

$imageSource = [System.Windows.Interop.Imaging]::CreateBitmapSourceFromHIcon($icon.Handle, [System.Windows.Int32Rect]::Empty,
[System.Windows.Media.Imaging.BitmapSizeOptions]::FromEmptyOptions()
)
$window.Icon = $imageSource
#>> Running (Get-Icon.ps1) Script Selection...
#>> Platform: V5 64Bit (STA)
#ERROR: Unable to find type [System.Windows.Interop.Imaging].
#Get-Icon.ps1 (61, 1): ERROR: At Line: 61 char: 1
#ERROR: + $imageSource = [System.Windows.Interop.Imaging]::CreateBitmapSourceFr ...
#ERROR: + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#ERROR:     + CategoryInfo          : InvalidOperation: (System.Windows.Interop.Imaging:TypeName) [], RuntimeException
#ERROR:     + FullyQualifiedErrorId : TypeNotFound
#ERROR:
#ERROR: The property 'Icon' cannot be found on this object. Verify that the property exists and can be set.
#Get-Icon.ps1 (64, 1): ERROR: At Line: 64 char: 1