<#	
	.NOTES
	===========================================================================
	 Created : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	6/6/2016 4:41 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#PS> [System.Management.Automation.Language.CodeGeneration] | Get-Member -Static
#
#
#
#TypeName: System.Management.Automation.Language.CodeGeneration
#
#Name                            MemberType Definition
#---- ---------- ----------
#EscapeBlockCommentContent       Method     static string EscapeBlockCommentContent(string value)
#EscapeFormatStringContent       Method     static string EscapeFormatStringContent(string value)
#EscapeSingleQuotedStringContent Method     static string EscapeSingleQuotedStringContent(string value)
#EscapeVariableName              Method     static string EscapeVariableName(string value)
#ReferenceEquals                 Method     static bool ReferenceEquals(System.Object objA, System.Object objB)
#
#For example, if you want to display single quotes inside a single quoted string, here is how the text would need to look like:
[System.Management.Automation.Language.CodeGeneration]::EscapeSingleQuotedStringContent("Contacting 'Bill'")

#Contacting ''Bill''
