# see https://our.umbraco.org/documentation/getting-started/setup/install/permissions
# Umbraco needs write permissions to several subdirectories - change ownership to the IIS group: 

$acl = Get-Acl $env:UMBRACO_ROOT; `
$newOwner = [System.Security.Principal.NTAccount]('BUILTIN\IIS_IUSRS'); `
$acl.SetOwner($newOwner); `
Set-Acl -Path $env:UMBRACO_ROOT -AclObject $acl; `
Get-ChildItem -Path $env:UMBRACO_ROOT -Recurse | Set-Acl -AclObject $acl