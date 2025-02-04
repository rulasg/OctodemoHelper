<#
    .SYNOPSIS
    Retrieves open issues from a repository that were created by the current user.

    .DESCRIPTION
    This function uses the GitHub CLI to search for open issues in a specified repository
    that were created by the current user.

    .PARAMETER Org
    The organization name. Default is 'octodemo'.

    .PARAMETER Repo
    The repository name. Default is 'bootstrap'.

    .EXAMPLE
    Get-OctodemoDemos -Org 'octodemo' -Repo 'bootstrap'
#>
function Get-OctodemoDemos {
    [CmdletBinding()]
    param(
        [string]$Org = "octodemo",
        [string]$Repo = "bootstrap",
        [string]$Title,
        [switch]$Web,
        [switch]$OpenRepos,
        [switch]$codespacesInfo
    )

    if($Web){
        
        Open-OctodemoMyIssues -Org $Org -Repo $Repo
        return
    }

    $command = "gh search issues repo:$Org/$Repo author:@me is:open --json title,repository,url,labels"
    $json = Invoke-Expression $command 

    $json | Write-Verbose

    $issues = $json | ConvertFrom-Json -Depth 10

    if ($Title) {
        $issues = $issues | Where-Object { $_.title -like "*$Title*" }
    }

    if($codespacesInfo){
        $codespacesList = Get-LabCodespaces
    }

    $ret = $issues | ForEach-Object {

        $labels = $_.labels.name -join " , "

        $repoInfo = Get-OctodemoRepoFromIssue -url $_.url

        if ($repoInfo){
            $envRepo = "$($repoInfo.Owner)/$($repoInfo.Repo)"
            $envRepoUrl = $repoInfo.Url

            # Open the repository in the browser if $openRepos is set
            if($OpenRepos){
                Open-Url -url $envRepoUrl
            }
        }

        $customObject = [PSCustomObject]@{
            Title = $_.title
            Repository = $_.repository.nameWithOwner
            Url = $_.url
            Repo = $envRepo
            RepoUrl = $envRepoUrl
            Labels = $labels
        }

        if ($codespacesList -and $envRepo) {
            $codespace = $codespacesList | Where-Object { $_.Repository -eq $envRepo }
            if ($codespace) {
            $customObject | Add-Member -MemberType NoteProperty -Name CodespaceDisplayName -Value $codespace.DisplayName
            $customObject | Add-Member -MemberType NoteProperty -Name CodespaceName -Value $codespace.Name
            }
        }

        $customObject
    }

    $ret | Write-Verbose

    return $ret

} Export-ModuleMember -Function 'Get-OctodemoDemos'

function Get-OctodemoRepoFromIssue{
    [CmdletBinding()]
    param(
        [string]$url
    )
    $json = gh issue view $url --comments --json comments
    
    $issue = $json | ConvertFrom-Json -Depth 10

    # last comment
    $comment = $issue.comments[-1].body

    $lines = $comment -split "`n"

    $line = $lines | Select-String -Pattern "Demo repository"

    #if line is null return null
    if($null -eq $line){
        return $null
    }

    $ret = Get-RepoInfoFromString -inputString $line

    return $ret
}

function Get-RepoInfoFromString{
    [CmdletBinding()]
    param(
        [string]$inputString
    )
    # Extract the owner, repo, and url from the input string
    $pattern = '\[(?<owner>[^\/]+)\/(?<repo>[^\]]+)\]\((?<url>[^)]+)\)'
    $match = [regex]::Matches($inputString, $pattern)
    if ($match.Count -gt 0) {
        $owner = $match[0].Groups['owner'].Value
        $repo = $match[0].Groups['repo'].Value
        $url = $match[0].Groups['url'].Value
        return [PSCustomObject]@{
            Owner = $owner
            Repo = $repo
            Url = $url
        }
    } else {
        Write-Error "No match found"
    }
} Export-ModuleMember -Function 'Get-RepoInfoFromString'

function Open-OctodemoMyIssues{
    [CmdletBinding()]
    param(
        [string]$Org = "octodemo",
        [string]$Repo = "bootstrap"
    )

    $url = "https://github.com/{org}/{repo}/issues?q=is%3Aissue%20state%3Aopen%20author%3A%40me"
    $url = $url -replace "{org}", $Org
    $url = $url -replace "{repo}", $Repo
    
    Open-Url $url
} Export-ModuleMember -Function 'Open-OctodemoMyIssues'

function Open-Url{
    [CmdletBinding()]
    param(
        [Parameter(Position=0)][string]$url
    )

    if ($IsWindows) {
        Start-Process $url
    } elseif ($IsMacOS) {
        open $url
    } elseif ($IsLinux) {
        xdg-open $url
    } else {
        Write-Error "Unsupported platform"
    }
} Export-ModuleMember -Function 'Open-Url'