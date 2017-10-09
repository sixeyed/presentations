# start the service
Write-Verbose 'Starting SQL Server'
start-service MSSQL`$SQLEXPRESS

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

# attach data files if they exist: 
$mdfPath = 'c:\database\AuditDB_Primary.mdf'
if ((Test-Path $mdfPath) -eq $true) {
    $sqlcmd = "CREATE DATABASE AuditDB ON (FILENAME = N'$mdfPath')"
    $ldfPath = 'c:\database\AuditDB_Primary.ldf'
    if ((Test-Path $mdfPath) -eq $true) {
        $sqlcmd =  "$sqlcmd, (FILENAME = N'$ldfPath')"
    }
    $sqlcmd = "$sqlcmd FOR ATTACH;"
    Write-Verbose "Invoke-Sqlcmd -Query $($sqlcmd) -ServerInstance '.\SQLEXPRESS'"
    Invoke-Sqlcmd -Query $sqlcmd -ServerInstance ".\SQLEXPRESS"
}

# deploy or upgrade the database:
$SqlPackagePath = 'C:\Program Files (x86)\Microsoft SQL Server\130\DAC\bin\SqlPackage.exe'
& $SqlPackagePath  `
    /sf:DockerSamples.AspNetChat.Database.dacpac `
    /a:Script /op:create.sql /p:CommentOutSetVarDeclarations=true `
    /tsn:.\SQLEXPRESS /tdn:AuditDB /tu:sa /tp:$sa_password 

$SqlCmdVars = "DatabaseName=AuditDB", "DefaultFilePrefix=AuditDB", "DefaultDataPath=c:\database\", "DefaultLogPath=c:\database\"  
Invoke-Sqlcmd -InputFile create.sql -Variable $SqlCmdVars -Verbose

# relay SQL event logs to Docker
$lastCheck = (Get-Date).AddSeconds(-2) 
while ($true) { 
    Get-EventLog -LogName Application -Source "MSSQL*" -After $lastCheck | Select-Object TimeGenerated, EntryType, Message	 
    $lastCheck = Get-Date 
    Start-Sleep -Seconds 2 
}