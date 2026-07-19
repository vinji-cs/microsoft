# Replace this with code with your own code :)
$path = "C:\Temp\ComSim.txt"

# Create a file and directory
if (!(Test-Path $path)) {
    New-Item -ItemType File -Path $path -Force | Out-Null
}

# Append the current date
(Get-Date) | Add-Content -Path $path
