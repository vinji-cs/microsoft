$taskName = "ComSim - ScheduledTask System"

$task = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue

if ($task) {
    # Task exists > detection success
    Write-Host "Detection success"
    exit 0
} else {
    # Task not found > detection failed
    Write-Host "Detection Failed"
    exit 1
}