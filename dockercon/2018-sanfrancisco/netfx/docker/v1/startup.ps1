Write-Output 'Starting IIS'
Start-Service W3SVC

Write-Output 'Tailing log'
Invoke-WebRequest http://localhost/ -UseBasicParsing | Out-Null
Get-Content -Path "C:\logs\WebFormsApp.log" -Tail 1 -Wait 