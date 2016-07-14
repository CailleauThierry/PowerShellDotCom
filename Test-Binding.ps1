<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	7/14/2016 4:20 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#requires -Version 2
#Understanding Type-Based Parameter Binding
#PowerShell 2+
#
#PowerShell can automatically bind arguments to parameters based on type. Simply define different parameter sets. Here is an example:

function Test-Binding
{
	#Content
	[CmdletBinding(DefaultParameterSetName = 'Number')]
	param
	(
		[String][Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'Text', Position = 0)]
		$Name,
		[int][Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'Number', Position = 0)]
		$Length = -1
	)
	
	$set = $PSCmdlet.ParameterSetName
	"You called the function with the $set parameter set"
}


666 | Test-Binding
"Hello" | Test-Binding
#
#When you call the function with a number, the "Number" parameter set is identified, and the argument is bound to the -Length parameter. If you submit a text, it ends up in the –Name parameter.
#Using type-based parameter binding, your functions can deal with a variety of incoming information.
# me: tested to work on PS v2 and v5 (64-bits)
#>> Running (Test-Binding.ps1) Script...
#>> Platform: V2 64Bit (STA)
#ERROR:, : The "=" operator is missing after a named argument.
#ERROR:     + CategoryInfo          : ParserError: (:) [], ParseException
#ERROR:     + FullyQualifiedErrorId : MissingEqualsInNamedArgument
#ERROR:
#
#>> Execution time: 00:00:01
#>> Script Ended
#------------
#>> Running (Test-Binding.ps1) Script...
#>> Platform: V5 64Bit (STA)
#You called the function with the Number parameter set
#You called the function with the Text parameter set
#
#>> Execution time: 00:00:01
#>> Script Ended