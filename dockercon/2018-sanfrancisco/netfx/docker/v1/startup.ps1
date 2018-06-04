Write-Output 'STARTUP: Starting IIS'
Start-Service W3SVC

Write-Output 'STARTUP: Tailing log'
Invoke-WebRequest http://localhost/ -UseBasicParsing | Out-Null
Get-Content -Path "C:\logs\WebFormsApp.log" -Tail 1 -Wait 