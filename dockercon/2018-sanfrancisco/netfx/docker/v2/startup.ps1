Write-Output 'Loading config files'
RedirectConfigFile($env:LOG4NET_CONFIG_PATH, "$env:APP_ROOT\log4net.config")
RedirectConfigFile($env:APP_SETTINGS_CONFIG_PATH, "$env:APP_ROOT\appSettings.config")
       
Write-Output 'Starting IIS'
Start-Service W3SVC

Write-Output 'Tailing log'
Invoke-WebRequest http://localhost/ -UseBasicParsing | Out-Null
Get-Content -Path "C:\logs\WebFormsApp.log" -Tail 1 -Wait 

function RedirectConfigFile(string $sourcePath, string $targetPath) {
    if ($sourcePath -And (Test-Path $sourcePath)) {
    
        Remove-Item -Force -Path $targetPath
            
        New-Item -Path $targetPath `
                -ItemType SymbolicLink `
                -Value $sourcePath

        Write-Verbose "INFO: Loaded config from source file"
    }
}