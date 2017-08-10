param(
    [Parameter(Mandatory=$true)]
    [string] $sa_password,

    [Parameter(Mandatory=$true)]
    [string] $data_path)

# start the service
Write-Verbose 'Starting SQL Server'
Start-Service MSSQL`$SQLEXPRESS

if ($sa_password -ne "_") {
	Write-Verbose 'Changing SA login credentials'
    $sqlcmd = "ALTER LOGIN sa with password='$sa_password'; ALTER LOGIN sa ENABLE;"
    Invoke-SqlCmd -Query $sqlcmd -ServerInstance ".\SQLEXPRESS" 
}

$mdfPath = "$data_path\NerdDinner_Primary.mdf"
$ldfPath = "$data_path\NerdDinner_Primary.ldf"

# attach data files if they exist: 
if ((Test-Path $mdfPath) -eq $true) {
    $sqlcmd = "IF DB_ID('NerdDinner') IS NULL BEGIN CREATE DATABASE NerdDinner ON (FILENAME = N'$mdfPath')"
    if ((Test-Path $ldfPath) -eq $true) {
        $sqlcmd =  "$sqlcmd, (FILENAME = N'$ldfPath')"
    }
    $sqlcmd = "$sqlcmd FOR ATTACH; END"
    Write-Verbose 'Data files exist - will attach and upgrade database'
    Invoke-Sqlcmd -Query $sqlcmd -ServerInstance ".\SQLEXPRESS"
}
else {
     Write-Verbose 'No data files - will create new database'
}

# deploy or upgrade the database:
$SqlPackagePath = 'C:\Program Files (x86)\Microsoft SQL Server\130\DAC\bin\SqlPackage.exe'
& $SqlPackagePath  `
    /sf:NerdDinner.Database.dacpac `
    /a:Script /op:deploy.sql /p:CommentOutSetVarDeclarations=true `
    /tsn:.\SQLEXPRESS /tdn:NerdDinner /tu:sa /tp:$sa_password 

$SqlCmdVars = "DatabaseName=NerdDinner", "DefaultFilePrefix=NerdDinner", "DefaultDataPath=$data_path\", "DefaultLogPath=$data_path\"  
Invoke-Sqlcmd -InputFile deploy.sql -Variable $SqlCmdVars -Verbose

Write-Verbose "Deployed NerdDinner database, data files at: $data_path"

$lastCheck = (Get-Date).AddSeconds(-2) 
while ($true) { 
    Get-EventLog -LogName Application -Source "MSSQL*" -After $lastCheck | Select-Object TimeGenerated, EntryType, Message	 
    $lastCheck = Get-Date 
    Start-Sleep -Seconds 2 
}