function RedirectConfigFile {
    param([string] $sourcePath, [string] $targetPath)

    if ($sourcePath -And (Test-Path $sourcePath)) {
    
        Remove-Item -Force -Path $targetPath
            
        New-Item -Path $targetPath `
                -ItemType SymbolicLink `
                -Value $sourcePath

        Write-Output "STARTUP: Redirected $targetPath config to read from $sourcePath"
    }
}

Write-Output 'STARTUP: Loading config files'
RedirectConfigFile $env:LOG4NET_CONFIG_PATH "$env:APP_ROOT\log4net.config"
RedirectConfigFile $env:APPSETTINGS_CONFIG_PATH "$env:APP_ROOT\appSettings.config"
RedirectConfigFile $env:CONNECTIONSTRINGS_CONFIG_PATH "$env:APP_ROOT\connectionStrings.config"

if ($env:DEPENDENCY_CHECK_ENABLED) {
    Write-Output 'STARTUP: Validating dependencies'
    & $env:APP_ROOT\DependencyChecker.exe
    if ($LastExitCode -ne 0) {
        return 1
    }
}

Write-Output 'STARTUP: Starting IIS'
Start-Service W3SVC

Write-Output 'STARTUP: Tailing log'
Invoke-WebRequest http://localhost/ -UseBasicParsing | Out-Null
Get-Content -Path "C:\logs\WebFormsApp.log" -Tail 1 -Wait 