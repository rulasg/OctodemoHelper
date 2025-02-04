<#
.SYNOPSIS
Creates a codespace in the main branch of a specified GitHub repository.

.DESCRIPTION
The `New-Codespace` function creates a new codespace in the main branch of a specified GitHub repository using the GitHub CLI (`gh`).

.PARAMETER Repo
The repository name with the owner in the format 'owner/repo'.

.EXAMPLE
New-Codespace -RepoWithOwner 'octodemo/mushy-chainsaw'
This example creates a codespace in the main branch of the 'octodemo/mushy-chainsaw' repository.

.NOTES
Requires GitHub CLI (gh) to be installed and authenticated.
#>
function New-LabCodespace {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipelineByPropertyName)][string]$Repo,
        [Parameter(Position=1)][string]$DisplayName,
        [switch]$CheckIfExists
    )

    begin{

        if($CheckIfExists){
            $codespaces = Get-LabCodespaces
        }
    }

    process{

        if ($CheckIfExists ) {

            # Check if repo name starts with $LAB_ORG
            $orgName, $repoName = $Repo -split '/'
            if ($orgName -ne $LAB_ORG) {
                Write-Error "Repository $Repo does not belong to organization $LAB_ORG"
                return
            }

            # check if codespace already exists
            $existingCodespace = $codespaces | Where-Object { $_.Repository -eq $Repo }
            if ($existingCodespace) {
                Write-Warning "Codespace in repository $Repo already exists"
                return
            }
        }

        "Creating codespace in the main branch of $Repo" | Write-Verbose
        
        $ghCommand = "gh cs create -b main -m 'standardLinux32gb' -R $Repo"
        if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey('DisplayName')) {
            $ghCommand += " --display-name '$DisplayName'"
        }

        $result = Invoke-Expression $ghCommand
        
        $result | Write-Verbose
        
        return $result
    }

} Export-ModuleMember -Function 'New-LabCodespace'


function Get-LabCodespaces {
    [CmdletBinding()]
    param(
        [Parameter(Position=0)][string]$owner = 'octodemo'
    )

    "Getting codespaces in the $Repo repository" | Write-Verbose

    $json = gh cs list --json name,displayName,owner,repository

    $json | Write-Verbose

    $codespaces = $json | ConvertFrom-Json -Depth 10

    $result = $codespaces | Where-Object { $_.repository -Like "$owner/*" } | ForEach-Object {
        [PSCustomObject]@{
            Name = $_.name
            DisplayName = $_.displayName
            Owner = $_.owner
            Repository = $_.repository
        }
    }

    $result | Write-Verbose

    return $result
} Export-ModuleMember -Function 'Get-LabCodespaces'

function Remove-LabCodespace{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory,ValueFromPipelineByPropertyName,Position=0)]
        [Alias("CodespaceName")]
        [string]$Name,
        [Parameter()][object]$CodespaceList
    )

    begin{
        $codespacesList ??= Get-LabCodespaces

        $codespacesList | Write-Verbose
    }

    process{

        $command = "gh codespace delete --codespace $Name --force"

        $codespacesList ??= Get-LabCodespaces

        $codespace = $codespacesList | Where-Object { $_.Name -eq $Name }

        if($codespace){
            if ($PSCmdlet.ShouldProcess($Command)) {
                "Removing codespace $Name" | Write-Verbose
                $result = Invoke-Expression $command
                $result | Write-Output
                "Codespace $Name removed" | Write-Host
            }
        } else {
            "Codespace $Name not found" | Write-Host
        }

    }
} Export-ModuleMember -Function 'Remove-LabCodespace'