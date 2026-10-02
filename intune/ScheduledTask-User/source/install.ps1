 # Working directory
$basePath = "$env:ProgramData\ComSim-ScheduledTask-User\"

# Script used by the scheduled task 
$userScript  = Join-Path -Path "$basePath" -ChildPath "task-user.ps1"

# Create the directory if it does not exists
if (!(Test-Path -Path $basePath)) {
    New-Item `
        -Path $basePath `
        -ItemType Directory `
        -Force | Out-Null
}

# SID of current user, we will use this to create a unique name for the task
$SID = [System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value 

# Remove the scheduled task if it is present. We will create a new one with the same name.
Unregister-ScheduledTask `
    -TaskName "ComSim - ScheduledTask User - $SID" `
    -Confirm:$false `
    -ErrorAction SilentlyContinue

# Copy the script we want to run with the scheduled task to the directory
Copy-Item `
    (Join-Path -Path "$PSScriptRoot\files" -ChildPath "task-user.ps1") `
    $userScript `
    -Force

# Everything is in place, lets create the scheduled task

# 1. Lets define the action, we want to run PowerShell which will then execute the task in the given location
$action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$userScript`""

# 2. The action that will trigger the scheduled task, a logon of the user 
# Because the user (under which this script is running) is not allowed to create tasks for other users
# We will have to specify the account the which can trigger the task (the current user).
$user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$trigger = New-ScheduledTaskTrigger -AtLogOn -User $user
$trigger.Delay = "PT2M" # If needed you can add a delay (e.g. 2 min), remove this line if it is not needed

# 3. Settings for the task::
# -StartWhenAvailable: Indicates that Task Scheduler can start the task at any time after its scheduled time has passed.
# -DontStopIfGoingOnBatteries: Indicates that the task does not stop if the computer switches to battery power.
# -AllowStartIfOnBatteries: Indicates that Task Scheduler starts if the computer is running on battery power. It will still run if its plugged in ;)
$taskSettings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable      

Register-ScheduledTask `
-TaskName "ComSim - ScheduledTask User - $SID" `
-Action $action `
-Trigger $trigger `
-Settings $taskSettings `
-Description "Complex Simplicity scheduled task" `
-Force