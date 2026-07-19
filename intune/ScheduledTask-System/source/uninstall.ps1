# The directory where we stored the script which had to be run by the scheduleded task
$basePath = "$env:ProgramData\ComSim-ScheduledTask-System\"

# Remove the scheduled task if it is present.
Unregister-ScheduledTask `
    -TaskName "ComSim - ScheduledTask System" `
    -Confirm:$false `
    -ErrorAction SilentlyContinue

# Remove the directory and all the files within
Remove-Item -Path "$basePath" -Recurse -Force