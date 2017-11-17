# start the service
Write-Host 'Starting SQL Server'
Start-Service MSSQL`$SQLEXPRESS
$sa_password='_'

$secretPath = $env:PASSWORD_PATH
if (Test-Path $secretPath) {
    $sa_password = Get-Content -Raw $secretPath
	Write-Host 'Changing SA login credentials'
    $sqlcmd = "ALTER LOGIN sa with password='$sa_password'; ALTER LOGIN sa ENABLE;"
    Invoke-SqlCmd -Query $sqlcmd -ServerInstance ".\SQLEXPRESS" 
}
else {
    Write-Host "SA password not found at: $secretPath"
    return 1
}

$lastCheck = (Get-Date).AddSeconds(-2) 
while ($true) { 
    Get-EventLog -LogName Application -Source "MSSQL*" -After $lastCheck | Select-Object TimeGenerated, EntryType, Message	 
    $lastCheck = Get-Date 
    Start-Sleep -Seconds 2 
}