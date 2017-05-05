$nuGetPath = "C:\Chocolatey\bin\nuget.bat"
$msBuildPath = "C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe"

cd c:\src
& $nuGetPath restore .\ProductLaunch.sln

& $msBuildPath .\ProductLaunch.MessageHandlers.IndexProspect\ProductLaunch.MessageHandlers.IndexProspect.csproj /p:OutputPath=c:\out\index-prospect\IndexProspectHandler
