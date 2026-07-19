# The directory where we stored the script which had to be run by the scheduleded task
$basePath = "$env:ProgramData\ComSim-ScheduledTask-User\"

# SID of the current user
$SID = [System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value 

# Remove the scheduled task if it is present.
Unregister-ScheduledTask `
    -TaskName "ComSim - ScheduledTask User - $SID" `
    -Confirm:$false `
    -ErrorAction SilentlyContinue

# Remove the directory and all the files within
Remove-Item -Path "$basePath" -Recurse -Force