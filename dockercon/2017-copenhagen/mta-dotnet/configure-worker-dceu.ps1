
$SkipEngineUpgrade=$false
$DockerVersion='17.06'
$DockerWindowsVersion='17.06.1-ee-1'
$DTRFQDN='ddc086-dtr-34jsc65qhr4le.westeurope.cloudapp.azure.com'
$UcpVersion='2.2.3'

#Variables
$Date = Get-Date -Format "yyyy-MM-dd HHmmss"
$DockerDataPath = "C:\ProgramData\Docker"

function Disable-RealTimeMonitoring () {
    Set-MpPreference -DisableRealtimeMonitoring $true
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 1 /f
    reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f
}

function Install-LatestDockerEngine () {
    Invoke-WebRequest -Uri "https://download.docker.com/components/engine/windows-server/$DockerVersion/docker-$DockerWindowsVersion.zip" -OutFile "docker.zip"

    Stop-Service docker
    Remove-Item -Force -Recurse $env:ProgramFiles\docker
    Expand-Archive -Path "docker.zip" -DestinationPath $env:ProgramFiles -Force
    Remove-Item docker.zip

    Start-Service docker
}

function Disable-Firewall () {
    #Disable firewall (temporary)
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

    #Ensure public profile is disabled (solves public profile not persisting issue)
    $data = netsh advfirewall show publicprofile
    $data = $data[3]
    if ($data -Match "ON"){
        Set-NetFirewallProfile -Profile Public -Enabled False
    }
}

function Set-DtrHostnameEnvironmentVariable() {
    $DTRFQDN | Out-File (Join-Path $DockerDataPath "dtr_fqdn")
}

function Get-UcpImages() {
    docker pull docker/ucp-dsinfo-win:$UcpVersion
    docker pull docker/ucp-agent-win:$UcpVersion

    Add-Content setup.ps1 $(docker run --rm docker/ucp-agent-win:$UcpVersion windows-script)
    & .\setup.ps1
    Remove-Item -Force setup.ps1
}

#Start Script
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

try
{
    Start-Transcript -path "C:\ProgramData\Docker\configure-worker $Date.log" -append

    Write-Host "Disabling Real Time Monitoring"
    Disable-RealTimeMonitoring
    
    if (-not ($SkipEngineUpgrade.IsPresent)) {
        Write-Host "Upgrading Docker Engine"
        Install-LatestDockerEngine
    }

    Write-Host "Getting UCP Images"
    Get-UcpImages

    Write-Host "Disabling Firewall"
    Disable-Firewall

    Write-Host "Set DTR FQDN Environment Variable"
    Set-DtrHostnameEnvironmentVariable

    Stop-Transcript
}
catch
{
    Write-Error $_
}
