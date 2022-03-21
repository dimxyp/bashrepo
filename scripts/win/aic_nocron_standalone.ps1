$Time = New-ScheduledTaskTrigger -At 01:00 -Once
Set-ScheduledTask -TaskName "AIC fetch" -Trigger $Time
Set-ScheduledTask -TaskName "AIC scanning" -Trigger $Time
Set-ScheduledTask -TaskName "IBM ILMT hardware capacity scan" -Trigger $Time
