<#
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	02_26_2020 6:21 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename: Get-ConsoleBufferAsHtml.ps1
	===========================================================================
	.DESCRIPTION
		If you’d like to hardcopy the content of a PowerShell console, you can copy and select the text, but this messes up colors and formatting.
A better way is reading the console screen buffer, and composing HTML documents. These HTML documents can then be copied and pasted into Word and other targets, and keep formatting and colors.
		Tested to work on Win 10 with PSVersion = 5.1.18362.628
#>

function Get-ConsoleBufferAsHtml
{
$html = [Text.StringBuilder]''
$null = $html.Append("<pre style='MARGIN: 0in 10pt 0in;
      line-height:normal';
      font-family:Consolas;
  font-size:10pt; >")
$bufferWidth = $host.UI.RawUI.BufferSize.Width
$bufferHeight = $host.UI.RawUI.CursorPosition.Y

$rec = [Management.Automation.Host.Rectangle]::new(
0,0,($bufferWidth - 1),$bufferHeight
  )
$buffer = $host.ui.rawui.GetBufferContents($rec)

for($i = 0; $i -lt $bufferHeight; $i++)
  {
$span = [Text.StringBuilder]''
$foreColor = $buffer[$i, 0].Foregroundcolor
$backColor = $buffer[$i, 0].Backgroundcolor
for($j = 0; $j -lt $bufferWidth; $j++)
    {
$cell = $buffer[$i,$j]
if (($cell.ForegroundColor -ne $foreColor) -or ($cell.BackgroundColor -ne $backColor))
      {
$null = $html.Append(
"<span style='color:$foreColor;background:$backColor'>$($span)</span>"
        )
$span = [Text.StringBuilder]''
$foreColor = $cell.Foregroundcolor
$backColor = $cell.Backgroundcolor
      }
Add-Type -AssemblyName System.Web

$null = $span.Append([System.Web.HttpUtility]::HtmlEncode($cell.Character))

    }
$null = $html.Append(
"<span style='color:$foreColor;background:$backColor'>$($span)</span><br/>"
    )
  }

$null = $html.Append("</pre>")
$html.ToString()
}

Get-ConsoleBufferAsHtml | Set-Content $env:temp\test.html
Invoke-Item $env:temp\test.html

<# Note that this function requires a true console window, so it won’t work in the PowerShell ISE. When you run the code above, it provides you with a new command called Get-ConsoleBufferAsHtml.
To hard-copy the current console content to a HTML file, run this:
PS>  Get-ConsoleBufferAsHtml | Set-Content $env:temp\test.html
Note how the code enables TLS1.2. Whether this protocol is required depends on your connection and firewalls. In the example above, it is not required. For other download URLs, it may.
PS>  Invoke-Item $env:temp\test.html
 #>
# Result from PS Console and note worlking from VSCODE:

<# <pre style='MARGIN: 0in 10pt 0in;
      line-height:normal';
      font-family:Consolas;
  font-size:10pt; ><span style='color:DarkYellow;background:DarkMagenta'>PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PowerShellDotCom&gt; </span><span style='color:Yellow;background:DarkMagenta'>./Get-ConsoleBufferAsHtml.ps1</span><span style='color:DarkYellow;background:DarkMagenta'>                                                                                     </span><br/></pre>

 #>