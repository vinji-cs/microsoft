$SID = [System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value 
$taskName = "ComSim - ScheduledTask User - $SID"

$task = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue

if ($task) {
    # Task exists > detection success
    exit 0
} else {
    # Task not found > detection failed
    exit 1
}