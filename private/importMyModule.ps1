# function Import-DemoHelper{

#     ## Check if demohelper avaialble in the peer folder

#     $local = $PSScriptRoot | Split-Path -Parent

#     $sideBySide = $local | Split-Path -Parent | Join-Path -ChildPath "DemoHelper"

#     if(Test-Path -path $sideBySide){
#         Import-Module $sideBySide -Force
#     } else {
#         Import-MyModule -Name Import-DemoHelper -PassThru
#     }


# }


# function Import-DependencyModule{
#     [CmdletBinding()]
#     param (
#         [Parameter(Mandatory)][string]$Name,
#         [Parameter()][string]$Version,
#         [Parameter()][switch]$AllowPrerelease,
#         [Parameter()][switch]$PassThru
#     )
    
#     if ($Version) {
#         $V = $Version.Split('-')
#         $semVer = $V[0]
#         $AllowPrerelease = ($AllowPrerelease -or ($null -ne $V[1]))
#     }

#     # Check if module is already installed. Use the version parameter transformation
#     $module = Import-Module -Name $Name -PassThru -ErrorAction SilentlyContinue -RequiredVersion:$semVer -Verbose

#     # If module not installed, install it
#     if ($null -eq $module) {
#         # Install module from PowershellGallery
#         $installed = Install-Module -Name $Name -Force -PassThru -AllowPrerelease:$AllowPrerelease  -RequiredVersion:$Version -Verbose

#         # Now install the module that we have just installed
#         $module = Import-Module -Name $installed.Name -Force -PassThru -RequiredVersion ($installed.Version.Split('-')[0]) -Verbose
#     }

#     if ($PassThru) {
#         $module
#     }
# }