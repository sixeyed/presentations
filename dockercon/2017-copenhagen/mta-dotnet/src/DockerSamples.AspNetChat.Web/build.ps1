
nuget restore packages.config `
    -PackagesDirectory ..\packages

msbuild DockerSamples.AspNetChat.Web.csproj `
    /p:OutputPath=c:\out `
    /p:DeployOnBuild=true `
    /p:VSToolsPath=C:\MSBuild.Microsoft.VisualStudio.Web.targets.14.0.0.3\tools\VSToolsPath