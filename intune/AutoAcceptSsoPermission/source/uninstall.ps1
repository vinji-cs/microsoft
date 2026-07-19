$registryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AAD"

if((Get-ItemPropertyValue -Path $registryKeyPath -Name "AutoAcceptSsoPermission" -ErrorAction SilentlyContinue)) 
{ 
    Remove-ItemProperty -Path $registryKeyPath -Name "AutoAcceptSsoPermission" -Force 
}