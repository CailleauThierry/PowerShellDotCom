<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	6/24/2016 10:53 AM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
##Sorting Multiple Properties
#
##Sort-Object can sort multiple properties. Just submit a comma separated list:
#
#Get-Service | Sort-Object -Property Status, Name | Out-GridView
#
##This line sorts all services first by status, and then by name. However, how would you sort multiple properties in different orders? Let's say you want the status in descending order, but the name in ascending order? Here is how:
 
Get-Service |
 Sort-Object -Property @{E='Status'; A=$False},@{E='Name';A=$True} |
 Out-GridView

#In this example, you submit hash tables per property. "E" is short for "Expression". It takes the property name you want to sort. "A" is short for "Ascending" and takes a Boolean value.
# me: works with ISE and console PS 5, "Out-GridView" first supported in version 
