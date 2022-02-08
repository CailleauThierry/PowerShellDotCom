<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	02_08_2022 6:30 AM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	Set-CalendarToCSVExcel.ps1
	===========================================================================
	.DESCRIPTION
<# Creating Calendar Spreadsheets with PowerShell
All Versions (I tested it on PS 5.1.19041.1320)
Ever needed to plan recurring meetings for your club, community or hobby? Sure, there are tons of online tools to help you but if you'd just like to create a calendar list in Microsoft Excel, PowerShell can be an excellent helper.
Let's assume you have a recurring meeting every Wednesday, and the meeting starts at 12PM except in the last week of each month. 
Rather than adding these dates and times manually to an Excel sheet, you may want to use PowerShell like this:  #>
# generate calendar for weekly incidents
 
$startdate = [DateTime]'2022-06-01'
$numberOfWeeks = 52
$result = for ($week = 0; $week -lt $numberOfWeeks; $week ++) 
{
  # calculate the real date each week
  $realdate = $startdate + (New-Timespan -days (7*$week))
  
  # calculate the current month
  $month = $realdate.Month
 
  # calculate the days in this month
  $daysInMonth = [DateTime]::DaysInMonth($realdate.Year, $realdate.Month)
 
  # make arbitrary adjustments, i.e. set start time to 12PM by default, but 7PM on the last week of a month
 
  # are we in the last week of a month?
  if ($realdate.Day -gt ($daysInMonth- 7))
  {
    # add 19 hours
    $realdate = $realdate.AddHours(19)
  }
  else
  {
    # add 12 hours
    $realdate = $realdate.AddHours(12)
  }
  
  # create your Excel sheet layout as a CSV file
  [PSCustomObject]@{
    Start = $realdate
    IsOnline = $false
    Title = ''
    Speaker = ''
    Notes = ''
  }
} 
 
 
$path = "$env:temp\calendar.csv"
$result | Export-Csv -UseCulture -Path $path -Encoding UTF8 -NoTypeInformation 
 
# open CSV in Excel
Start-Process -FilePath excel -ArgumentList $path 

<# This script illustrates a number of useful techniques: 
•	Constructing dates in a loop with offsets (7 days in this example, could be easily adjusted to any other interval)
•	Identifying "last week in month" by calculating the days in a current month, then making adjustments on a date based on this
•	Generating CSV data and opening CSV in Microsoft Excel (if installed) #>


<# 
Resulting C:\Users\<userName>\AppData\Local\Temp\calendar.csv content

"Start","IsOnline","Title","Speaker","Notes"
"6/1/2022 12:00:00 PM","False","","",""
"6/8/2022 12:00:00 PM","False","","",""
"6/15/2022 12:00:00 PM","False","","",""
"6/22/2022 12:00:00 PM","False","","",""
"6/29/2022 7:00:00 PM","False","","",""
"7/6/2022 12:00:00 PM","False","","",""
"7/13/2022 12:00:00 PM","False","","",""
"7/20/2022 12:00:00 PM","False","","",""
"7/27/2022 7:00:00 PM","False","","",""
"8/3/2022 12:00:00 PM","False","","",""
"8/10/2022 12:00:00 PM","False","","",""
"8/17/2022 12:00:00 PM","False","","",""
"8/24/2022 12:00:00 PM","False","","",""
"8/31/2022 7:00:00 PM","False","","",""
"9/7/2022 12:00:00 PM","False","","",""
"9/14/2022 12:00:00 PM","False","","",""
"9/21/2022 12:00:00 PM","False","","",""
"9/28/2022 7:00:00 PM","False","","",""
"10/5/2022 12:00:00 PM","False","","",""
"10/12/2022 12:00:00 PM","False","","",""
"10/19/2022 12:00:00 PM","False","","",""
"10/26/2022 7:00:00 PM","False","","",""
"11/2/2022 12:00:00 PM","False","","",""
"11/9/2022 12:00:00 PM","False","","",""
"11/16/2022 12:00:00 PM","False","","",""
"11/23/2022 12:00:00 PM","False","","",""
"11/30/2022 7:00:00 PM","False","","",""
"12/7/2022 12:00:00 PM","False","","",""
"12/14/2022 12:00:00 PM","False","","",""
"12/21/2022 12:00:00 PM","False","","",""
"12/28/2022 7:00:00 PM","False","","",""
"1/4/2023 12:00:00 PM","False","","",""
"1/11/2023 12:00:00 PM","False","","",""
"1/18/2023 12:00:00 PM","False","","",""
"1/25/2023 7:00:00 PM","False","","",""
"2/1/2023 12:00:00 PM","False","","",""
"2/8/2023 12:00:00 PM","False","","",""
"2/15/2023 12:00:00 PM","False","","",""
"2/22/2023 7:00:00 PM","False","","",""
"3/1/2023 12:00:00 PM","False","","",""
"3/8/2023 12:00:00 PM","False","","",""
"3/15/2023 12:00:00 PM","False","","",""
"3/22/2023 12:00:00 PM","False","","",""
"3/29/2023 7:00:00 PM","False","","",""
"4/5/2023 12:00:00 PM","False","","",""
"4/12/2023 12:00:00 PM","False","","",""
"4/19/2023 12:00:00 PM","False","","",""
"4/26/2023 7:00:00 PM","False","","",""
"5/3/2023 12:00:00 PM","False","","",""
"5/10/2023 12:00:00 PM","False","","",""
"5/17/2023 12:00:00 PM","False","","",""
"5/24/2023 12:00:00 PM","False","","","" #>

