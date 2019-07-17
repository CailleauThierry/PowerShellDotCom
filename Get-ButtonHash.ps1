
# Posted by : 	Powershell.com <yourpowertip@powershell.com>
# Get-ButtonHash.ps1 Tested to work by Thierry Cailleau  on 07_17_2019 with PSVersion                      5.1.15063.1805
$timeoutSeconds = 5
$title = 'Important'
$message = 'Restart Computer?'

$buttons = @{
  OK               = 0
  OkCancel         = 1
  AbortRetryIgnore = 2
  YesNoCancel      = 3
  YesNo            = 4
  RetryCancel      = 5
}

$icon = @{
  Stop        = 16
  Question    = 32
  Exclamation = 48
  Information = 64
}

$clickedButton = @{
  -1 = 'Timeout'
  1  = 'OK'
  2  = 'Cancel'
  3  = 'Abort'
  4  = 'Retry'
  5  = 'Ignore'
  6  = 'Yes'
  7  = 'No'
}

$shell = New-Object -ComObject WScript.Shell
$value = $shell.Popup($message, $timeoutSeconds, $title, $buttons.YesNo + $icon.Question)

"Raw result: $value"
"Cooked result: " + $clickedButton.$value

Switch ($clickedButton.$value)
{
  'Yes'    { 'restarting' }
  'No'     { 'aborted' }
  'Timeout'{ 'you did not make a choice' }
}
