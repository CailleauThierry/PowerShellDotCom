<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	7/13/2016 9:15 AM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#More Splitting Fun
#
#In the previous tip, we explained how you can use a regular expression to split strings in groups of a given length. Let's explore what else can be done with this approach:
#To split regular text in chunks of 5 character words, try this:
 
'Hello World, this is a text splitter!' -split '(?<=\G.{5})(?=.)' 
 
#This would produce hex pairs from a list of hexadecimals:
 
'00A1B26A7E100009' -split '(?<=\G[A-Fa-f0-9]{2})(?=.)' 
 
#And this would produce decimal values from a list of hexadecimals:
 
('00A1B26A7E100009' -split '(?<=\G[A-Fa-f0-9]{2})(?=.)').Foreach{[Convert]::ToInt32($_, 16)}

# me: there was a typo in the "{2}" and "{5}" those can't ahve spaces in them
# note: sounds line .NET take the /g (global) regex option implicitly
