# Adapted from Microsoft's SQL Server Express sample:
# https://github.com/Microsoft/sql-server-samples/blob/master/samples/manage/windows-containers/mssql-server-2016-express-windows/start.ps1

param(
    [Parameter(Mandatory=$true)]
    [string] $sa_password 
)

# start the service
Write-Verbose 'Starting SQL Server'
start-service MSSQL`$SQLEXPRESS

if ($sa_password -ne "_") {
	Write-Verbose 'Changing SA login credentials'
    $sqlcmd = "ALTER LOGIN sa with password='$sa_password'; ALTER LOGIN sa ENABLE;"
    Invoke-Sqlcmd -Query $sqlcmd -ServerInstance ".\SQLEXPRESS" 
}

$mdfPath = 'C:\mssql\SignUpDb.mdf'
$ldfPath = 'C:\mssql\SignUpDb_log.ldf'

# attach data files if they exist: 
if ((Test-Path $mdfPath) -eq $true) {
    $sqlcmd = "IF DB_ID('SignUpDb') IS NULL BEGIN CREATE DATABASE SignUpDb ON (FILENAME = N'$mdfPath')"
    if ((Test-Path $ldfPath) -eq $true) {
        $sqlcmd =  "$sqlcmd, (FILENAME = N'$ldfPath')"
    }
    $sqlcmd = "$sqlcmd FOR ATTACH; END"
    Write-Verbose 'Data files exist - will attach and upgrade database'
    Invoke-Sqlcmd -Query $sqlcmd -Verbose
}
else {
     Write-Verbose 'No existing data files - will create new database'
     Invoke-Sqlcmd -InputFile C:\init\init-db.sql -Verbose
}

$lastCheck = (Get-Date).AddSeconds(-2) 
while ($true) { 
    Get-EventLog -LogName Application -Source "MSSQL*" -After $lastCheck | Select-Object TimeGenerated, EntryType, Message	 
    $lastCheck = Get-Date 
    Start-Sleep -Seconds 2 
}