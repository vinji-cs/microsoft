$registryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AAD"

if(!(Test-Path -Path $registryKeyPath)){
	New-Item -Path $registryKeyPath -Force | Out-Null
}

New-ItemProperty -Path $registryKeyPath -Name "AutoAcceptSsoPermission" -Value "1" -PropertyType DWORD -Force | Out-Null