# The directory where we store the script which has to be run by the scheduleded task
$basePath = "$env:ProgramData\ComSim-ScheduledTask-System\"

# Script used by the scheduled task 
$systemScript  = Join-Path -Path "$BasePath" -ChildPath "task-system.ps1"

# Create the directory if it does not exists
if (!(Test-Path -Path $basePath)) {
    New-Item `
        -Path $basePath `
        -ItemType Directory `
        -Force | Out-Null
}

# Remove the scheduled task if it is present. We will create a new one with the same name.
Unregister-ScheduledTask `
    -TaskName "ComSim - ScheduledTask System" `
    -Confirm:$false `
    -ErrorAction SilentlyContinue

# Copy the script we want to run with the scheduled task to the directory
Copy-Item `
    (Join-Path -Path "$PSScriptRoot\files" -ChildPath "task-system.ps1") `
    $systemScript `
    -Force

# Everything is in place, lets create the scheduled task      

# 1. Lets define the action, we want to run PowerShell which will then execute the task in the given location
$action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$systemScript`""

# 2. The action that will trigger the scheduled task, a logon of (any) user 
$trigger = New-ScheduledTaskTrigger -AtLogOn

# 3. Settings for the task::
# -StartWhenAvailable: Indicates that Task Scheduler can start the task at any time after its scheduled time has passed.
# -DontStopIfGoingOnBatteries: Indicates that the task does not stop if the computer switches to battery power.
# -AllowStartIfOnBatteries: Indicates that Task Scheduler starts if the computer is running on battery power. It will still run if its plugged in ;)
$taskSettings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable      

# 4. Register the scheduled task
# -User: This will indicate that it will run under SYSTEM context    
# -RunLevel: Run at the highest privilege level
Register-ScheduledTask `
-TaskName "ComSim - ScheduledTask System" `
-Action $action `
-Trigger $trigger `
-Settings $taskSettings `
-User "SYSTEM" `
-RunLevel Highest `
-Description "Complex Simplicity scheduled task" `
-Force

# Please note, if this task is created using Microsoft Intune, it will not show up in the Task Scheduler. 
# It will be however possible to see the task running a elevated powershell cmdlet; Get-Scheduled Task-TaskName "ComSim - ScheduledTask System"
