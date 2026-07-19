> **Intunewin32: AutoAcceptSsoPermission**

### Commands
Install Command: **%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -file .\install.ps1**
Uninstall Command: **%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -file .\uninstall.ps1**
Install behavior: **System**

### Detection

| Detection Option     | Value         |
| ------------- |-------------|
| Key path      | HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AAD     |
| Value name      | AutoAcceptSsoPermission     |
| Detection method     | Integer comparison     |
| Operator     | Equals     |
| Value     | 1     |

Associated with a 32-bit app on 64-bit clients: **No**
