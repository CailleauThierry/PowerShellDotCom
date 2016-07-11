<#	
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	7/11/2016 12:44 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#requires -Version 2
#Doing Things in Parallel
#Any version
#
#By processing things in parallel rather than sequential, a script can complete much faster. Here is an example that uses background jobs to execute three tasks in parallel:

# three things to do... 
$task1 = { Start-Sleep -Seconds 5; 1 }
$task2 = { Start-Sleep -Seconds 7; 2 }
$task3 = { Start-Sleep -Seconds 3; 3 }

# do two things in the background... 
$job1 = Start-Job -ScriptBlock $task1
$job3 = Start-Job -ScriptBlock $task3

# do one thing in our process... 
$resultTask2 = & $task2

# wait for the other two background tasks to complete... 
$null = Wait-Job -Job $job1, $job3

# get the results from these background tasks... 
$resultTask1 = Receive-Job -Job $job1
$resultTask3 = Receive-Job -Job $job3

# clean up... 
Remove-Job -Job $job1, $job3

# here we go with all three task results 
$resultTask1
$resultTask2
$resultTask3

#Just be aware that background jobs need to serialize their results to transfer them back to you. They are most efficient if the background task can complete the job without the need to transfer lots of data back to the foreground process.
#
#me: results runs in PS v2 and v5 (64-bits)
#>> Running (Set-ParallelDemo.ps1) Script...
#>> Platform: V2 64Bit (STA)
#1
#2
#3
#
#>> Execution time: 00:00:09
#>> Script Ended
#
#>> Running (Set-ParallelDemo.ps1) Script...
#>> Platform: V5 64Bit (STA)
#1
#2
#3
#
#>> Execution time: 00:00:09
#>> Script Ended
