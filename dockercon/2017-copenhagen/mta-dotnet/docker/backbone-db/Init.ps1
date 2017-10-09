# start the service
Write-Host 'Starting SQL Server'
Start-Service MSSQL`$SQLEXPRESS

$sa_password='DockerCon!!!'

$secretPath = $env:PASSWORD_PATH
if (Test-Path $secretPath) {
    $sa_password = Get-Content -Raw $secretPath
}
else {
    Write-Host "WARN: Using default SA password, secret file not found at: $secretPath"
}

Write-Host 'Changing SA login credentials'
$sqlcmd = "ALTER LOGIN sa with password='$sa_password'; ALTER LOGIN sa ENABLE;"
Invoke-SqlCmd -Query $sqlcmd -ServerInstance ".\SQLEXPRESS" 

$lastCheck = (Get-Date).AddSeconds(-2) 
while ($true) { 
    Get-EventLog -LogName Application -Source "MSSQL*" -After $lastCheck | Select-Object TimeGenerated, EntryType, Message	 
    $lastCheck = Get-Date 
    Start-Sleep -Seconds 2 
}