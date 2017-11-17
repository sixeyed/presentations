Write-Output 'Bootstrap starting'

# copy process-level environment variables (from `docker run`) machine-wide
foreach($key in [System.Environment]::GetEnvironmentVariables('Process').Keys) {
    if ([System.Environment]::GetEnvironmentVariable($key, 'Machine') -eq $null) {
        $value = [System.Environment]::GetEnvironmentVariable($key, 'Process')
        [System.Environment]::SetEnvironmentVariable($key, $value, 'Machine')
        Write-Output "Set environment variable: $key"
    }
}

Start-Service W3SVC
    
Invoke-WebRequest http://localhost/ProductLaunch -UseBasicParsing | Out-Null
    
Get-Content -path 'C:\web-app\App_Data\SignUp.log' -Tail 1 -Wait